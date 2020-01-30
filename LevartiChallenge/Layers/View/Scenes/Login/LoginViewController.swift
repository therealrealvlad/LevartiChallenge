//
//  LoginViewController.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `LoginDisplaying` protocol specifies how the implementing class displays login scene views in the app.
 
 Note that the implemtning class must be of type `UIViewController`.
 */
protocol LoginDisplaying where Self: UIViewController {

    /// Displays the alert model view when an error occurs
    /// - Parameter alertModel: The alert model to display
    func display(alertModel: View.Alert.Model)
}

final class LoginViewController: UIViewController, LoginDisplaying {
    
    // MARK: Properties

    /// The login interactor
    var interactor: LoginInteracting?
    
    // MARK: Displaying

    func display(alertModel: View.Alert.Model) {
        Thread.runOnMain {
            // Guard against cases where the navigation controller may not have been set when an alert arrives (e.g. during unit tests of the render scene)
            guard let navigationController = self.navigationController else {
                return
            }
            View.Alert.present(alertModel: alertModel, on: navigationController)
        }
    }
    
    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

