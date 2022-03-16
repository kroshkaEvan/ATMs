//
//  MainViewController.swift
//  Task4
//
//  Created by Эван Крошкин on 22.02.22.
//

import Network
import SnapKit
import UIKit

class MainViewController: UIViewController {
    private let networkManager = NetworkManager()
    private var model: ATMModel?
    private var monitor = NWPathMonitor()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.insertSegment(withTitle: Constants.Strings.map,
                                       at: 0,
                                       animated: true)
        segmentedControl.insertSegment(withTitle: Constants.Strings.list,
                                       at: 1,
                                       animated: true)
        segmentedControl.selectedSegmentIndex = 2
        return segmentedControl
    }()

    private lazy var contentView: UIView = {
        let container = UIView()
        return container
    }()

    private lazy var mapViewController: MapViewController = {
        var viewController = MapViewController()
        self.set(view: contentView, viewController)
        return viewController
    }()

    private lazy var listViewController: ListViewController = {
        var viewController = ListViewController()
        self.set(view: contentView, viewController)
        return viewController
    }()
    
    private lazy var loadingView: LoadingView = {
       let loading =  LoadingView()
        loading.layer.zPosition = 999
        return loading
    }()

    private lazy var updateButton: UIBarButtonItem = { UIBarButtonItem(barButtonSystemItem: .refresh,
                                                                       target: self,
                                                                       action: #selector(updateModel)) }()

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(self,
                                   action: #selector(segmentAction(_: )),
                                   for: .valueChanged)
        fetchATMsData()
        setupVCs()
        updateView()
    }

    func forceMapCallout(for title: String) {
        segmentedControl.selectedSegmentIndex = 0
        updateView()
        mapViewController.selectAnnotation(with: title)
    }

    private func fetchATMsData() {
        checkConnectionNetwork()
        showLodingView()
        self.model = nil
        listViewController.model = nil
        mapViewController.model = nil
        networkManager.fetchATMData { model, _ in
            self.model = model
            self.listViewController.model = model?.data.atm
            self.mapViewController.model = model?.data.atm
            DispatchQueue.main.async {
                self.mapViewController.configure{ self.hideLoading() }
                self.listViewController.prepareModelForCollectionView()
                self.listViewController.collectionView.reloadData()
                self.updateButton.isEnabled = true
            }
        }

    }
    
//    private func showAlert() {
//        let alert = UIAlertController(title: Constants.Strings.internetAlertTitle,
//                                      message: Constants.Strings.internetAlertMessage,
//                                      preferredStyle: .alert)
//        let action = UIAlertAction(title: Constants.Strings.internetAlertButtonTitle,
//                                   style: .default,
//                                   handler: { [weak self] _ in
//            self?.updateButton.isEnabled = true
//            self?.hideLoading()
//        })
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }
    
    private func showLodingView() {
        contentView.addSubview(loadingView)
        loadingView.frame = contentView.bounds
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func hideLoading() {
        loadingView.removeFromSuperview()
    }

    private func checkConnectionNetwork() {
        monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
              print("Connected")
           } else {
              print("Disconnected")
           }
           print(path.isExpensive)
        }
    }

    private func setupVCs() {
        view.addSubview(segmentedControl)
        view.addSubview(contentView)
        view.backgroundColor = .gray
        self.navigationItem.setRightBarButton(updateButton, animated: true)
        setDefaultSegment()
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setDefaultSegment() {
        self.changeVCs(view: contentView, mapViewController, listViewController)
    }

    private func updateView() {
        let selectedSegment = segmentedControl.selectedSegmentIndex
        switch selectedSegment {
        case 0:
            setDefaultSegment()
            navigationController?.navigationBar.topItem?.title = Constants.Strings.map
        case 1:
            self.changeVCs(view: contentView, listViewController, mapViewController)
            navigationController?.navigationBar.topItem?.title = Constants.Strings.list
        default:
            break
        }
    }

    @objc func segmentAction(_ sender: UISegmentedControl) {
        updateView()
    }

    @objc func updateModel() {
        updateButton.isEnabled = false
        fetchATMsData()
    }
}
