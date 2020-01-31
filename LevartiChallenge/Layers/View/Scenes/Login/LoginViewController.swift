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
    
    /// Specifies the login delegate that must be implemented by the view controller
    var delegate: LoginDelegate? { get set }
    
    /// Pops the login view controller off the navigation stack
    func pop()

    /// Displays the alert model view when an error occurs
    /// - Parameter alertModel: The alert model to display
    func display(alertModel: View.Alert.Model)
}

protocol LoginDelegate {
    /// Tells the implementing class that the login view controller popped off the navigatin stack
    func didPop()
}

final class LoginViewController: UIViewController, LoginDisplaying {
    
    /// The constants used in the  `LoginViewController` class
    enum Constants {
        /// The min number of username characters
        static let minUsernameCount: Int = 8
        
        /// The min number of password characters
        static let minPasswordCount: Int = 8
    }
    
    // MARK: Outlets

    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    // MARK: Actions
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let username = username.text,
            username.count >= Constants.minUsernameCount else {
                display(alertModel: View.Alert.Model(title: "Invalid Username",
                                                     message: "You must enter a username with at least \(Constants.minUsernameCount) characters",
                                                     primaryActionTitle: "OK",
                                                     primaryActionStyle: .default))
                return
        }
        
        guard let password = password.text,
            password.count >= Constants.minPasswordCount else {
                display(alertModel: View.Alert.Model(title: "Invalid Password",
                                                     message: "You must enter a password with at least \(Constants.minPasswordCount) characters",
                                                     primaryActionTitle: "OK",
                                                     primaryActionStyle: .default))
                return
        }
        
        interactor?.login(withViewModel: View.Login.Model(username: username, password: password))
    }
    
    // MARK: Properties

    /// The login interactor
    var interactor: LoginInteracting?
    
    /// The login delegate
    var delegate: LoginDelegate?
    
    // MARK: Displaying
    
    func pop() {
        navigationController?.popViewController(animated: true)
        delegate?.didPop()
    }

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
        navigationItem.title = "Login"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}

