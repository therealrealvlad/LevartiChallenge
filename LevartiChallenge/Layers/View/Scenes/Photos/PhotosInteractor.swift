//
//  PhotosInteractor.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `PhotosInteracting` protocol specifies how the implementing class interacts with the domain level model to display photos content in the app.
 */
protocol PhotosInteracting {
    
    /// Displays the photos view
    /// - Parameters:
    ///   - view: The host view
    func show(onView view: UIView)
}

final class PhotosInteractor: PhotosInteracting {
    
    // MARK: Properties
    
    /// The photos presenter
    let presenter: PhotosPresenting
    
    // MARK: Lifecycle
    
    /// Initializes the interactor
    /// - Parameter presenter: A view controller conforming to the `PhotosPresenting` protocol
    init(presenter: PhotosPresenting) {
        self.presenter = presenter
    }
    
    // MARK: PhotosInteracting conformance
    
    func show(onView view: UIView) {

    }
}
