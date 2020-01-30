//
//  Domain+Load.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import Foundation
import Combine

extension Domain {
    
    /// The `Load` namespace is used for all domain-level data loading in the app.
    enum Load {
        
        /// The optional model property
        private static var model: Model?
        
        /// The `Model` struct encapsulates data-to-domain mapped model.
        struct Model {
            // TODO: Figure out the properties for the domain model
        }
        
        /// The `Error` enum maps the data error to the domain error.
        enum Error: Swift.Error {
            // TODO: Correctly map the data errors into domain errors
            case passthrough(Swift.Error)
        }
        
        static func load(fromURL url: URL, errorCompletion: @escaping (Error) -> ()) {
            // Call the publisher to receive the data model (or error) on the main thread
            let publisher = Data.Load.load(from: url)
            
            // Create a completion to deal with any potential errors
            let completion: (Subscribers.Completion<Error>) -> () = { complete in
                switch complete {
                case .finished:
                    break
                case .failure(let error):
                    errorCompletion(error)
                }
            }
            
            // Create a value to return the data model
            let value: (Model) -> () = { domainModel in
                model = domainModel
            }
            
            // Apply the sink method to publish the completion and value
            let _ = publisher.sink(receiveCompletion: completion, receiveValue: value)
        }
    }
}
