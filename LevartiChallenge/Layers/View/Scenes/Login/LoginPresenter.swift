//
//  LoginPresenter.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `LoginPresenting` protocol specifies how the implementing class presents the login view in the app.
 */
protocol LoginPresenting {
    
    /// Tells the presenter to pop the login view controller off the navigation stack
    func pop()
    
    /// Presents the view message
    /// - Parameter message: The message to present
    typealias Message = String
    func present(message: Message)
}

final class LoginPresenter: LoginPresenting {
    
    // MARK: Properties
    
    /// The view controller conforming to the `LoginDisplaying` protocol
    let viewController: LoginDisplaying
    
    // MARK: Lifecycle
    
    /// Initializes the presenter
    /// - Parameter viewController: A view controller conforming to the `LoginDisplaying` protocol
    init(viewController: LoginDisplaying) {
        self.viewController = viewController
    }
    
    // MARK: Presentation
    
    func pop() {
        viewController.pop()
    }
    
    func present(message: Message) {
        let alertModel = View.Alert.Model(title: NSLocalizedString("loginFailed",
                                                                   tableName: "Domain+Error+Localized",
                                                                   comment: ""),
                                          message: message,
                                          primaryActionTitle: NSLocalizedString("ok",
                                                                                tableName: "Domain+Error+Localized",
                                                                                comment: ""),
                                          primaryActionStyle: .default)
        viewController.display(alertModel: alertModel)
    }
}

