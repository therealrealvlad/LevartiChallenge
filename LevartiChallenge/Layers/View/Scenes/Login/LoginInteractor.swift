//
//  LoginInteractor.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `LoginInteracting` protocol specifies how the implementing class interacts with the domain level model to display login content in the app.
 */
protocol LoginInteracting {
    /// Attempts to log the user in into the app
    /// - Parameter model: The login view model
    func login(withViewModel model: View.Login.Model)
}

final class LoginInteractor: LoginInteracting {
    
    // MARK: Properties
    
    /// The login presenter
    let presenter: LoginPresenting
    
    // MARK: Lifecycle
    
    /// Initializes the interactor
    /// - Parameter presenter: A view controller conforming to the `LoginPresenting` protocol
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
    
    // MARK: LoginInteracting conformance
    
    func login(withViewModel model: View.Login.Model) {
        let result: (Domain.Login.Status) -> () = { status in
            // TODO: Display the login result
        }
        let loginManager = Data.Login.Manager(result: result)
        let domainModel = Domain.Login.Model(username: model.username, password: model.password)
        Domain.Login.login(withDomainModel: domainModel, on: loginManager)
    }
}
