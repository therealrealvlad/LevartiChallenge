//
//  AppNavigationController.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
The `AppNavigationController` class handles navigation within the app.
*/
final class AppNavigationController: UINavigationController {
    
    // MARK: Override Properties

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        navigationBar.barStyle = .default
        navigationBar.tintColor = .darkGray
    }
}
