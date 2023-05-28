//
//  TableViewCell.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 28/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private weak var imagesView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(with imageDetails: ImageDetails) {
        titleLabel.text = imageDetails.author

        if let download_url = imageDetails.download_url ,let imageURL = URL(string: download_url) {
            // Download and set the image asynchronously
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.imagesView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }

    static func calculateHeight(for imageDetails: ImageDetails, width: CGFloat) -> CGFloat {
        let imageHeight: CGFloat = 200 // Set the desired image height
        let titleLabelHeight: CGFloat = 30 // Set the desired title label height
        let padding: CGFloat = 16 // Set the desired padding

        return imageHeight + titleLabelHeight + (2 * padding) // Total cell height
    }
}

