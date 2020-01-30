//
//  Data+Load.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import Foundation
import Combine

extension Data {
    
    /// The `Load` namespace is used for all dataloading in the app.
    enum Load {
        
        /// The `Model` struct, which conforms to the `Decodable` protocol
        struct Model: Decodable {

        }
        
        // Returns a Combine publisher mapping the data/error to the domain layer
        static func load(from url: URL) -> AnyPublisher<Domain.Load.Model, Domain.Load.Error> {
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: Data.Load.Model.self, decoder: JSONDecoder())
                .mapError { domainError(from: $0) }
                .compactMap { domainModel(from: $0) }
                .eraseToAnyPublisher()
        }
        
        // MARK: Private helpers
        
        private static func domainModel(from dataModel: Data.Load.Model) -> Domain.Load.Model {
            // TODO: Create a mapper method that maps the data model to a domain model
            return Domain.Load.Model()
        }
        
        private static func domainError(from dataError: Error) -> Domain.Load.Error {
            // TODO: Create a mapper method that maps the data error to a domain error that is suitable for display to the user
            return .passthrough(dataError)
        }
    }
}
