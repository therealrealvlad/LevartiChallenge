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
    
    /// Returns the data model provided by the async URL load
    /// - Parameter url: The url to use
    func load(fromURL url: URL)
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
    
    func load(fromURL url: URL) {
        Domain.Load.load(fromURL: url) { result in
            switch result {
            case .success(let model):
                print(model)
                break
            case .failure(let error):
                self.presenter.present(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: Private helper methods
    
    private func fetchImages(fromURLs urls: [URL]) {
        
    }

}
