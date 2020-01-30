//
//  View+Load.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

extension View {
    
    /// The `Load` namespace is used for all load view model handling in the app.
    enum Load {
        
        /// The `Model` struct encapsulates the item title, image and thumbnail.
        struct Model {
            
            /// The item title
            let title: String
            
            /// The full size image item url
            let fullsizeImageURL: URL
            
            /// The thumbnail image item url
            let thumbnailImageURL: URL
        }
        
        /// The `Build` namespace is used for all load view building in the app.
        enum Build {
            
            /// Returns the the built login scene
            static func build() -> PhotosDisplaying {
                let viewController = PhotosViewController()
                let presenter = PhotosPresenter(viewController: viewController)
                let interactor = PhotosInteractor(presenter: presenter)
                viewController.interactor = interactor
                return viewController
            }
        }
    }
}
