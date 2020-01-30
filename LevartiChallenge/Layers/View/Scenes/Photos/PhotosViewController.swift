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
    /// - Parameter viewModel: The view model to display
    func display(viewModel: View.Load.ListModel)
    
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
    
    func display(viewModel: View.Load.ListModel) {
        // Stop the spinner
        activityIndicatorView.stopAnimating()
    }

    func display(alertModel: View.Alert.Model) {
        // Stop the spinner
        activityIndicatorView.stopAnimating()

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
        navigationItem.title = "Photos"
        navigationItem.setHidesBackButton(true, animated: false)
        activityIndicatorView.frame = view.bounds
        activityIndicatorView.style = .large
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        interactor?.load(fromURL: Data.Load.url.unsafelyUnwrapped)
    }
}

