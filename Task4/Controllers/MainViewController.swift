//
//  MainViewController.swift
//  Task4
//
//  Created by Эван Крошкин on 22.02.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.insertSegment(withTitle: "Map", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "List", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 2
        return segmentedControl
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(self,
                                   action: #selector(segmentAction(_:)),
                                   for: .valueChanged)
        setupVCs()
    }
    
    private func setupVCs() {
        view.addSubview(segmentedControl)
        view.addSubview(contentView)
        view.backgroundColor = .gray
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
            navigationController?.navigationBar.topItem?.title = "MAP ATMs"
    }
    
    func forceMapCallout(for title: String) {
        segmentedControl.selectedSegmentIndex = 0
        mapViewController.selectAnnotation(with: title)
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            setDefaultSegment()
        case 1:
            self.changeVCs(view: contentView, listViewController, mapViewController)
            navigationController?.navigationBar.topItem?.title = "LIST ATMs"
        default:
            break
        }
    }
}
