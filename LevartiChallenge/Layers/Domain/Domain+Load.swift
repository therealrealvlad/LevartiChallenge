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
        
        // MARK: Nested types

        /// The `Error` enum maps the data error to the domain error
        enum Error: String, LocalizedError, Equatable {
            // TODO: Map all the known URLSession API errors to their domain counterparts; we swallow the error for simplicity here, and just display a generic error message to the user
            case some
            
            var errorDescription: String? {
                return NSLocalizedString(rawValue, tableName: "Domain+Error+Localized", comment: rawValue)
            }
            
            static func == (lhs: Error, rhs: Error) -> Bool {
                return lhs.rawValue == rhs.rawValue
            }
        }
        
        /// The `Model` struct encapsulates domain model.
        struct Model {
            
            /// The album ID
            let albumId: Int
            
            /// The item ID
            let id: Int
            
            /// The item title
            let title: String
            
            /// The item url
            let url: URL
            
            /// The item thumbnail url
            let thumbnailUrl: URL
        }

        // MARK: Properties
        
        /// The subscriber's stored reference
        static var subscriber: AnyCancellable?
        
        /// Loads the data from the data layer
        /// - Parameters:
        ///   - url: The url to use
        ///   - result: The result
        static func load(fromURL url: URL, result: @escaping (Result<[Domain.Load.Model], Domain.Load.Error>) -> ()) {
            // Call the publisher to receive the data model
            let publisher = Data.Load.load(from: url)
            
            // Init the models array
            var models = [Domain.Load.Model]()
            
            // Create a completion to deal with any potential errors
            let completion: (Subscribers.Completion<Domain.Load.Error>) -> () = { complete in
                switch complete {
                case .finished:
                    result(.success(models))
                case .failure(let error):
                    result(.failure(error))
                }
            }
            
            // Create a value to return the domain model
            let value: ([Domain.Load.Model]) -> () = { domainModel in
                domainModel.forEach {
                    models.append($0)
                }
            }
            
            // Apply sink to publish the completion and value
            let subscriber = publisher.sink(receiveCompletion: completion, receiveValue: value)
            
            // Store the subscriber
            Load.subscriber = subscriber
        }
    }
}
