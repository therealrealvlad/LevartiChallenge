//
//  View+Alert.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

extension View {
    
    /// The `Alert` namespace is used for all alert view model handling in the app.
    enum Alert {
        
        /// Indicates whether the alert module is currently showing an alert
        private static var isPresenting: Bool = false
        
        /// The array of stored alerts
        private static var alertModels = [Model]()
        
        /// The most recently presenting view controller
        private static var presentingViewController: UIViewController? = nil
        
        /// The completion block to call when the alert has been dismissed with the primary action
        private static let primaryAction: ((UIAlertAction) -> Void) = { _ in
            // An alert is no longer being presented
            Alert.isPresenting = false
            
            // Execute the primary completion
            if let model = alertModels.first {
                model.primaryCompletion?()
                alertModels.removeFirst()
            }
            
            // Show the next one
            next()
        }
        
        /// The completion block to call when the alert has been dismissed with the secondary action
        private static let secondaryAction: ((UIAlertAction) -> Void) = { _ in
            Alert.isPresenting = false
            
            // Execute the secondary completion
            if let model = alertModels.first {
                model.secondaryCompletion?()
                alertModels.removeFirst()
            }
            
            next()
        }
        
        /// Update the alert models array and display outstanding alerts
        private static func next() {
            // Remove the dismissed alert, and show the next one, if there is one
            guard !alertModels.isEmpty else {
                presentingViewController = nil
                return
            }
            if let model = alertModels.first,
                let presentingViewController = presentingViewController {
                present(alertModel: model, on: presentingViewController)
                alertModels.removeFirst()
            }
        }
        
        /// The alert model
        struct Model {
            
            // MARK: Properties
            
            /// The alert title to display
            let title: String
            
            /// The alert message to display
            let message: String
            
            /// The primary alert action title
            let primaryActionTitle: String
            
            /// The primary alert action style
            let primaryActionStyle: UIAlertAction.Style
            
            /// The primary completion
            let primaryCompletion: (() -> Void)?
            
            /// An optional alert action title
            let secondaryActionTitle: String?
            
            /// An optional alert action style
            let secondaryActionStyle: UIAlertAction.Style?
            
            /// The secondary completion
            let secondaryCompletion: (() -> Void)?
            
            // MARK: Lifecycle

            init(title: String,
                 message: String,
                 primaryActionTitle: String,
                 primaryActionStyle: UIAlertAction.Style,
                 primaryCompletion: (() -> Void)? = nil,
                 secondaryActionTitle: String? = nil,
                 secondaryActionStyle: UIAlertAction.Style? = nil,
                 secondaryCompletion: (() -> Void)? = nil) {
                self.title = title
                self.message = message
                self.primaryActionTitle = primaryActionTitle
                self.primaryActionStyle = primaryActionStyle
                self.primaryCompletion = primaryCompletion
                self.secondaryActionTitle = secondaryActionTitle
                self.secondaryActionStyle = secondaryActionStyle
                self.secondaryCompletion = secondaryCompletion
            }
        }
        
        
        /// Presents an alert given the specified model
        /// - Parameter alertModel: The alert model
        /// - Parameter presentingViewController: The presenting view controller
        static func present(alertModel: Model, on presentingViewController: UIViewController) {
            // Store the alert, as we cannot display more than one alert at a time; when the user dismisses the current alert, the next one will be shown
            alertModels.append(alertModel)

            guard !Alert.isPresenting else {
                Alert.presentingViewController = presentingViewController
                return
            }
            
            // An alert is about to be presented
            Alert.isPresenting = true
            let alert = UIAlertController(title: alertModel.title,
                                          message: alertModel.message,
                                          preferredStyle: .alert)
            alert.overrideUserInterfaceStyle = .dark
            let alertAction = UIAlertAction(title: alertModel.primaryActionTitle,
                                            style: alertModel.primaryActionStyle,
                                            handler: primaryAction)
            alert.addAction(alertAction)
            if let secondaryActionTitle = alertModel.secondaryActionTitle,
                let secondaryActionStyle = alertModel.secondaryActionStyle {
                let secondaryAlertAction = UIAlertAction(title: secondaryActionTitle,
                                                         style: secondaryActionStyle,
                                                         handler: secondaryAction)
                alert.addAction(secondaryAlertAction)
            }
            presentingViewController.present(alert, animated: true, completion: nil)
        }
    }
}
