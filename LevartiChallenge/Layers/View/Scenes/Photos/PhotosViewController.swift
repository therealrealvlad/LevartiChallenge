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

final class PhotosViewController: UITableViewController, PhotosDisplaying, UISearchBarDelegate {
    
    // MARK: Constants

    /// The constants used in the  `PhotosViewController` class
    enum Constants {
        /// The default table view item row height
        static let defaultRowHeight: CGFloat = 100
    }
    
    // MARK: Selectors

    @objc private func refresh() {
        // Clear the search text and dismiss the keyboard prior to refresh
        searchBar.text = nil
        searchBar.resignFirstResponder()
        
        // Refresh the table view by calling the interactor to load the data again
        interactor?.load(fromURL: Data.Load.url.unsafelyUnwrapped)
    }
    
    
    // MARK: Properties
    
    /// The activity indicator view
    let activityIndicatorView = UIActivityIndicatorView()
    
    /// The photos interactor
    var interactor: PhotosInteracting?
    
    /// The original view models to load
    var originalViewModels = [View.Load.Model]()
    
    /// The view models to that have been deleted by the user (and so should not be reloaded upon refresh)
    var deletedViewModels = [View.Load.Model]()
    
    /// The filtered view models are used for display
    var filteredViewModels = [View.Load.Model]()
    
    /// The search bar
    lazy var searchBar = UISearchBar()
    
    // MARK: Displaying
    
    func display(viewModels: [View.Load.Model]) {
        // Ensure that all UIKit updates occur on the main thread
        Thread.runOnMain {
            // Stop the spinner
            if self.activityIndicatorView.isAnimating {
                self.activityIndicatorView.stopAnimating()
            }
            
            // Stop refreshing
            if let refreshControl = self.refreshControl,
            refreshControl.isRefreshing {
                self.refreshControl?.endRefreshing()
            }
            
            // Update the view models
            self.originalViewModels.removeAll()
            self.originalViewModels = viewModels.filter { !self.deletedViewModels.contains($0) }
            self.filteredViewModels = self.originalViewModels
            
            // Reload the table view
            self.tableView.reloadData()
        }
    }

    func display(alertModel: View.Alert.Model) {
        // Stop the spinner
        if self.activityIndicatorView.isAnimating {
            self.activityIndicatorView.stopAnimating()
        }
        
        // Ensure that all UIKit updates occur on the main thread
        Thread.runOnMain {
            // Guard against cases where the navigation controller may not have been set when an alert arrives (e.g. during unit tests of the render scene)
            guard let navigationController = self.navigationController else {
                return
            }
            
            // Present the alert model
            View.Alert.present(alertModel: alertModel, on: navigationController)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide the back button
        navigationItem.setHidesBackButton(true, animated: false)

        // Use the title view to host the search bar
        searchBar.showsCancelButton = true
        searchBar.autocapitalizationType = .none
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        // Register the photo view cell on the table view
        tableView.register(cellType: PhotoViewCell.self)
        
        // Add a refresh control to the table view
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        // Add an activity indicator view to the super view
        activityIndicatorView.frame = view.bounds
        activityIndicatorView.style = .large
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        // Call the interactor to start laoding the data
        interactor?.load(fromURL: Data.Load.url.unsafelyUnwrapped)
    }
    
    
    // MARK: TableViewDelegate conformance

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell of type PhotoViewCell
        let cell: PhotoViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        // Configure the cell with the image url from the indexed view model
        let model = filteredViewModels[indexPath.item]
        cell.configure(withThumbnailImageURL: model.thumbnailImageURL,
                       title: model.title)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            // The model to delete
            let model = filteredViewModels[indexPath.row]
            
            // Add the model to the deleted models array
            deletedViewModels.append(model)
            
            // Remove the model from the filtered and original model arrays
            filteredViewModels.remove(at: indexPath.row)
            originalViewModels.remove(at: indexPath.row)
            
            // Delete the item from the table view itself
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.defaultRowHeight
    }
    
    // MARK: SearchBarDelegate conformance
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredViewModels = filter(withText: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: Private helper methods

    private func filter(withText text: String) -> [View.Load.Model] {
        guard !text.isEmpty else {
            return originalViewModels
        }
        return originalViewModels.filter { $0.title.contains(text) }
    }

}

