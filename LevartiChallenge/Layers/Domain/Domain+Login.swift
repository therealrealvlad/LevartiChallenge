//
//  Domain+Login.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import Foundation

extension Domain {
    
    /// The `Login` namespace is used for all login handling in the app.
    enum Login {
        
        // MARK: Nested types
                
        /// Provides a convenient domain-level representation of the authorization states of the login service
        enum Status {
            
            /// Provides the reason the authorization status returned denied
            enum ReasonDenied: String {
                case noExistingUsername = "The username does not exist"
                case wrongPassword = "The password is incorrect"
            }
            
            case denied(ReasonDenied), granted
        }
                
        /// The `Error` enum maps the data error to the domain error.
        enum Error: Swift.Error {
            // TODO: Correctly map the data errors into domain errors
            case passthrough(Swift.Error)
        }
        
        /// Represents the login model for the user
        struct Model {
            /// The login username
            let username: String
            
            /// The login password
            let password: String
        }
                        
        // MARK: Methods
        
        static func login(withDomainModel model: Domain.Login.Model, on loginManager: LoginManaging) {
            loginManager.login(withDomainModel: model)
        }
    }
}
