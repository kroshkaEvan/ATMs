//
//  MainTabBarController.swift
//  Task4
//
//  Created by Эван Крошкин on 1.03.22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .purple
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: MainViewController(),
                                   title: "ATMs",
                                   image: UIImage(named: "contacts")),
            createNavController(for: CurrencyViewController(),
                                   title: "Currency",
                                   image: UIImage(named: "favorite")),
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
