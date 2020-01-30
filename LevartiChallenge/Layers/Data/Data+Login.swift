//
//  Data+Login.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import Foundation


/**
 The `LoginManaging` protocol specifies how the implementing class manages user login data in the app.
 */
protocol LoginManaging {
    
    /// The initializer for the login manager
    /// - Parameters:
    ///   - result: The login result
    ///   - mockableDataModel: The data model for mocking
    init(result: @escaping ((Domain.Login.Status) -> ()), mockableDataModel: Data.Login.Model)
    
    /// Performs the login using the specified domain model
    func login(withDomainModel model: Domain.Login.Model)
}


extension Data {
    
    /// The `Login` namespace is used for all login handling in the app.
    enum Login {
        
        // MARK: Nested types
        
        /// Represents the data-level login model for the user
        struct Model {
            /// The login username
            let username: String = "tony_vlad"
            
            /// The login password
            let password: String = "mobile_dev"
        }
        
        /// The login manager
        final class Manager: LoginManaging {
            
            // MARK: Properties
            
            /// The default data model (can be mocked to test the login manager)
            let defaultModel: Model
            
            /// The login status result
            let result: ((Domain.Login.Status) -> ())
            
            // MARK: LoginManaging conformance
            
            init(result: @escaping ((Domain.Login.Status) -> ()), mockableDataModel model: Model = Model()) {
                self.result = result
                self.defaultModel = model
            }
            
            func login(withDomainModel model: Domain.Login.Model) {
                result(compare(dataModel: Data.Login.Model(), withDomainModel: model))
            }
            
            // MARK: Private helpers
            
            /// Returns the data model for the given domain model
            /// - Parameter dataModel: The data model to map to the domain model
            private func compare(dataModel: Data.Login.Model, withDomainModel domainModel: Domain.Login.Model) -> Domain.Login.Status {
                if dataModel.username == domainModel.username {
                    if dataModel.password == domainModel.password {
                        return .granted
                    } else {
                        return .denied(.wrongPassword)
                    }
                } else {
                    return .denied(.noExistingUsername)
                }
            }
        }
    }
}
