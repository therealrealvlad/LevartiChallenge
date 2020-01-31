//
//  PhotosPresenter.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `PhotosPresenting` protocol specifies how the implementing class presents the photos view in the app.
 */
protocol PhotosPresenting {
    
    /// Presents the loaded content models
    /// - Parameter models: The view models to present
    func present(models: [View.Load.Model])
    
    /// Presents the view message
    /// - Parameter message: The message to present
    typealias Message = String
    func present(message: Message)
}

final class PhotosPresenter: PhotosPresenting {
    
    // MARK: Properties
    
    /// The view controller conforming to the `PhotosDisplaying` protocol
    let viewController: PhotosDisplaying
    
    // MARK: Lifecycle
    
    /// Initializes the presenter
    /// - Parameter viewController: A view controller conforming to the `PhotosDisplaying` protocol
    init(viewController: PhotosDisplaying) {
        self.viewController = viewController
    }
    
    // MARK: Presentation
    
    func present(models: [View.Load.Model]) {
        viewController.display(viewModels: models)
    }
    
    func present(message: Message) {
        let alertModel = View.Alert.Model(title: NSLocalizedString("unknownError",
                                                                   tableName: "Domain+Error+Localized",
                                                                   comment: ""),
                                          message: message,
                                          primaryActionTitle: NSLocalizedString("ok",
                                                                                tableName: "Domain+Error+Localized",
                                                                                comment: ""),
                                          primaryActionStyle: .default)
        viewController.display(alertModel: alertModel)
    }
}
