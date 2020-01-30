//
//  PhotoViewCell.swift
//  LevartiChallenge
//
//  Created by therealrealvlad on 30/1/20.
//  Copyright © 2020 Levarti. All rights reserved.
//

import UIKit

final class PhotoViewCell: UITableViewCell, NibReusable {
    
    // MARK: Outlets
    
    /// Displays the photo thumbnail
    @IBOutlet var photoView: UIImageView!
    
    /// Displays the photo title
    @IBOutlet var photoTitle: UILabel!
    
    // MARK: Override methods
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    // MARK: Public methods
    
    /// Configures the cell with the thumbnail url in order to display the photo
    func configure(withThumbnailImageURL url: URL) {
    }
}
