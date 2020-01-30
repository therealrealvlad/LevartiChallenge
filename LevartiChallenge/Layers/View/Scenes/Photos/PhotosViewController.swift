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
    
    /// Displays the view models
    /// - Parameter viewModels: The view models to display
    func display(viewModels: [View.Load.Model])
    
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
    
    /// The view models to load
    var viewModels = [View.Load.Model]()
    
    // MARK: Displaying
    
    func display(viewModels: [View.Load.Model]) {
        // Stop the spinner
        activityIndicatorView.stopAnimating()
        self.viewModels = viewModels
        tableView.reloadData()
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
        tableView.register(cellType: PhotoViewCell.self)
        activityIndicatorView.frame = view.bounds
        activityIndicatorView.style = .large
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        interactor?.load(fromURL: Data.Load.url.unsafelyUnwrapped)
    }
    
    // MARK: TableViewDelegate conformance

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell of type PhotoViewCell
        let cell: PhotoViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        // Configure the cell with the image url from the indexed view model
        cell.configure(withThumbnailImageURL: viewModels[indexPath.item].thumbnailImageURL)

        return cell
    }
}

