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
    private var locationManager: CLLocationManager?
    private let distanceSpan = 100
    private var currentLocationStr = "Текущее местоположение"

    var model: [ATM]?

    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: NSStringFromClass(MapAnnotation.self))
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func configure() {
        view.addSubview(mapView)
        activateConstraints()
        setupLocationManager()
        addAnnotations()
    }

    func selectAnnotation(with title: String) {
        guard let annotation = mapView.annotations.first(where: { $0.title == title }) else { return }
        mapView.selectAnnotation(annotation, animated: true)
    }

    private func activateConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    private func setupLocationManager() {
        self.locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    private func addAnnotations() {
        guard let model = model else { return }
        model.forEach { atm in
            let latitude = Double(atm.address.geolocation.geographicCoordinates.latitude) ?? 0
            let longtitude = Double(atm.address.geolocation.geographicCoordinates.longitude) ?? 0
            let annotation = MapAnnotation()
            annotation.title = atm.address.addressLine
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            self.mapView.addAnnotation(annotation)
        }
    }

    func setUsersClosestLocation(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lattitude, longitude: longitude)

        geoCoder.reverseGeocodeLocation(location) { placemarks, _ -> Void in
            if let mPlacemark = placemarks {
                if let dict = mPlacemark[0].addressDictionary as? [String: Any] {
                    if let name = dict["Name"] as? String {
                        if let city = dict["City"] as? String {
                            self.currentLocationStr = name + ", " + city
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        if let annotation = view.annotation, annotation.isKind(of: MapAnnotation.self) {

            }
        }

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

            let selectedATM = self.model?.first(where: { $0.address.addressLine == view.annotation?.title })
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
            cashInLabel.text = "Cash In: Да"
        } else {
            cashInLabel.text = "Cash In: Нет"
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
}
