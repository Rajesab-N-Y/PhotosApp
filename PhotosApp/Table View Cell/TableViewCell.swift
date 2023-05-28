//
//  TableViewCell.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 28/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private weak var imagesView: LazyImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    private var imageDetails: ImageDetails?

    func configure(with imageDetails: ImageDetails) {
        titleLabel.text = imageDetails.author
        if let imageUrl = URL(string: (imageDetails.download_url ?? "")){
            imagesView.loadImage(fromURL: imageUrl, placeHolderImage: "mushroom_img")
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imagesView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Adjust the height of the cell based on the image height

    }
    
    static func calculateHeight(for imageDetails: ImageDetails, width: CGFloat) -> CGFloat {
        let ratio = width / CGFloat(imageDetails.width ?? 0)
        let height = ratio * CGFloat(imageDetails.height ?? 0)
        return height
    }
}

