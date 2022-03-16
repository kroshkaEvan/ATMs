//
//  MapViewController.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: UIViewController {
    private var locationManager = LocationManager.shared
    private let distanceSpan = Constants.Location.distance
    private var currentLocationStr = Constants.Strings.currentLocation
    private var selectedATMCoordinates: CLLocationCoordinate2D?
    var model: [ATM]?
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: NSStringFromClass(MapAnnotation.self))
        view.addSubview(mapView)
        return mapView
    }()
    
    private lazy var routeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: Constants.Dimensions.defaultPadding * 4,
                                                              leading: Constants.Dimensions.defaultPadding * 4,
                                                              bottom: Constants.Dimensions.defaultPadding * 4,
                                                              trailing: Constants.Dimensions.defaultPadding * 4)
        button.configuration = configuration
        button.layer.cornerRadius = Constants.Dimensions.defaultCornerRadius
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitle(Constants.Strings.routeButtonText, for: .normal)
        button.titleLabel?.font = Constants.Fonts.sectionFont
        button.backgroundColor = Constants.Colors.appMainColor
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapRouteButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    func configure(completion: (() -> Void)?) {
        routeButton.addTarget(self,
                              action: #selector(didTapRouteButton),
                              for: .touchUpInside)
        mapView.addSubview(routeButton)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        routeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mapView.snp.bottom).offset(-Constants.Dimensions.defaultPadding * 4)
        }
        setupLocationManager()
        addAnnotations(completion: completion)
        completion?()
    }
    
    func selectAnnotation(with title: String) {
        guard let annotation = mapView.annotations.first(where: { $0.title == title }) else { return }
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    private func setupLocationManager() {
        locationManager.setDelegate(self)
    }
    
    private func addAnnotations(completion: (() -> Void)?) {
        guard let model = model else { return }
        model.forEach { [weak self] atm in
            let latitude = Double(atm.address.geolocation.geographicCoordinates.latitude) ?? 0
            let longtitude = Double(atm.address.geolocation.geographicCoordinates.longitude) ?? 0
            let annotation = MapAnnotation()
            annotation.title = atm.address.addressLine
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                           longitude: longtitude)
            self?.mapView.addAnnotation(annotation)
        }
        completion?()
    }
    
    private func setUsersClosestLocation(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lattitude,
                                  longitude: longitude)
        geoCoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ -> Void in
            if let mPlacemark = placemarks,
               let dict = mPlacemark[0].addressDictionary as? [String: Any],
               let name = dict[Constants.Strings.nameDictKey] as? String ,
               let city = dict[Constants.Strings.cityDictKey] as? String {
                self?.currentLocationStr = name + ", " + city
            }
        }
        return currentLocationStr
    }
    
    @objc private func didTapRouteButton() {
        guard let selectedATMCoordinates = selectedATMCoordinates else { return }
        routeButton.loadingAnimation()
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: selectedATMCoordinates))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                            longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        if let annotation = annotation as? MapAnnotation {
            annotationView = setupAnnotationView(for: annotation, on: mapView)
        }
        return annotationView
    }
    
    private func setupAnnotationView(for annotation: MapAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        let identifier = NSStringFromClass(MapAnnotation.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
        if let markerAnnotationView = view as? MKMarkerAnnotationView {
            markerAnnotationView.animatesWhenAdded = true
            markerAnnotationView.canShowCallout = true
            markerAnnotationView.markerTintColor = Constants.Colors.appMainColor
            
            let rightButton = UIButton(type: .detailDisclosure)
            markerAnnotationView.rightCalloutAccessoryView = rightButton
            
            let selectedATM = model?.first(where: { $0.address.addressLine == view.annotation?.title })
            
            markerAnnotationView.detailCalloutAccessoryView = setupMarkerDetails(for: selectedATM)
        }
        
        return view
    }
    
    private func setupMarkerDetails(for atm: ATM?) -> UIStackView {
        guard let atm = atm else { return UIStackView() }
        
        let ATMAvailability = atm.availability.standardAvailability.day
        let isCashInavailable = atm.services.contains(where: { $0.serviceType == .cashIn })
        let currency = atm.currency
        
        let availabilityView = AvailabilityView(for: ATMAvailability)
        availabilityView.isUserInteractionEnabled = false
        
        let cashInLabel = UILabel()
        if isCashInavailable {
            cashInLabel.text = Constants.Strings.cashInYes
        } else {
            cashInLabel.text = Constants.Strings.cashInNo
        }
        cashInLabel.font = Constants.Fonts.cellSubviewsFont
        
        let currencyLabel = UILabel()
        currencyLabel.text = currency.rawValue
        currencyLabel.font = Constants.Fonts.cellSubviewsFont

        let detailsStack = UIStackView()
        [availabilityView, cashInLabel, currencyLabel].forEach({ detailsStack.addArrangedSubview($0) })
        detailsStack.axis = .vertical
        detailsStack.alignment = .leading
        detailsStack.distribution = .fill
        detailsStack.spacing = 5
        return detailsStack
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let markerView = view as? MKMarkerAnnotationView,
              let selectedATM = model?.first(where: { $0.address.addressLine == markerView.annotation?.title }) else { return }
        
        let latitudeString = selectedATM.address.geolocation.geographicCoordinates.latitude
        let longtitudeString = selectedATM.address.geolocation.geographicCoordinates.longitude
        
        if let latitude = CLLocationDegrees(latitudeString),
           let longtitude = CLLocationDegrees(longtitudeString) {
            selectedATMCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            routeButton.isEnabled = true
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        selectedATMCoordinates = nil
        routeButton.isEnabled = false
    }
}
