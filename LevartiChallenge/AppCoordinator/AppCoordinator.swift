//
//  AppCoordinator.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `AppCoordinating` protocol specifies how the implementing class configures and presents views and performs operations in the app.
 */
protocol AppCoordinating {
    /// The root view controller of the app
    var rootViewController: UIViewController { get }
    
    /// Starts the display
    func start()
}

final class AppCoordinator: AppCoordinating {
    
    // MARK: Properties
    
    /// The navigation controller coordinates navigation between view controllers
    let navigationController = AppNavigationController()
    
    /// The container view controller contains/hosts the rendering and overlay view controllers
    let containerViewController = ContainerViewController()

    // MARK: Coordinating protocol conformance
    
    /// The root view controller for the app
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        // Set the container view controller as the root view controller
        navigationController.setViewControllers([containerViewController], animated: false)
        
        // Perform the login
        login()
    }
    
    // MARK: Private methods

    private func login() {
        let loginViewController: LoginDisplaying = View.Login.Build.build()
        loginViewController.delegate = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
}

extension AppCoordinator: LoginDelegate {
    func didPop() {
        let photosViewController: PhotosDisplaying = View.Load.Build.build()
        navigationController.pushViewController(photosViewController, animated: true)
    }
}
