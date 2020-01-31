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

        // MARK: Nested types
        
        /// The `Model` struct, which conforms to the `Decodable` protocol
        struct Model: Decodable {
            
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
        
        /// The static url used to load the data
        static let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        
        /// Returns a Combine publisher mapping the data/error to the domain layer
        /// - Parameter url: The url to use for the load
        static func load(from url: URL) -> AnyPublisher<[Domain.Load.Model], Domain.Load.Error> {
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [Data.Load.Model].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .mapError { domainError(from: $0) }
                .compactMap { domainModel(from: $0) }
                .eraseToAnyPublisher()
        }
        
        // MARK: Private helpers
        
        /// Returns the domain model given the data model
        /// - Parameter dataModel: The data model to map
        private static func domainModel(from dataModel: [Data.Load.Model]) -> [Domain.Load.Model] {
            let domainModel = dataModel.map { Domain.Load.Model(albumId: $0.albumId,
                                                                id: $0.id,
                                                                title: $0.title,
                                                                url: $0.url,
                                                                thumbnailUrl: $0.thumbnailUrl)
            }
            return domainModel
        }
        
        /// Returns the domain error for the specified data error
        /// - Parameter dataError: The data error to map
        private static func domainError(from dataError: Error) -> Domain.Load.Error {
            return .some
        }
    }
}
