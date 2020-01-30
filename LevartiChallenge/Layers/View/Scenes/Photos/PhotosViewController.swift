//
//  PhotosViewController.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

/**
 The `PhotosDisplaying` protocol specifies how the implementing class displays photos scene views in the app.
 
 Note that the implemtning class must be of type `UIViewController`.
 */
protocol PhotosDisplaying where Self: UIViewController {
    
    /// Displays the alert model view when an error occurs
    /// - Parameter alertModel: The alert model to display
    func display(alertModel: View.Alert.Model)
}

final class PhotosViewController: UITableViewController, PhotosDisplaying {
    
    // MARK: Properties
    
    /// The activity indicator view
    let activityIndicatorView = UIActivityIndicatorView()
    
    /// The photos interactor
    var interactor: PhotosInteracting?
    
    // MARK: Displaying

    func display(alertModel: View.Alert.Model) {
        Thread.runOnMain {
            // Guard against cases where the navigation controller may not have been set when an alert arrives (e.g. during unit tests of the render scene)
            guard let navigationController = self.navigationController else {
                return
            }
            View.Alert.present(alertModel: alertModel, on: navigationController)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        activityIndicatorView.frame = view.bounds
        activityIndicatorView.style = .large
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        interactor?.show(onView: view)
    }
}

