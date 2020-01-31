//
//  View+Login.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

extension View {
    
    /// The `Login` namespace is used for all login view model handling in the app.
    enum Login {
        
         /// Represents the login view model for the user
         struct Model {
             /// The login username
             let username: String
             
             /// The login password
             let password: String
         }
        
        /// The `Build` namespace is used for all login view building in the app.
        enum Build {
            
            /// Returns the the built login scene
            static func build() -> LoginDisplaying {
                let viewController = LoginViewController()
                let presenter = LoginPresenter(viewController: viewController)
                let interactor = LoginInteractor(presenter: presenter)
                viewController.interactor = interactor
                return viewController
            }
        }
    }
}
