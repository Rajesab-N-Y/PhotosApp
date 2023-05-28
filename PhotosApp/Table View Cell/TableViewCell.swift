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
    @IBOutlet private weak var checkboxButton: UIButton!

    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    private var imageDetails: ImageDetails?

    func configure(with imageDetails: ImageDetails, width: CGFloat) {
        titleLabel.text = imageDetails.author
        imageViewHeight.constant = calculateHeight(for: imageDetails, width: width)
        if let imageUrl = URL(string: (imageDetails.download_url ?? "")){
            imagesView.loadImage(fromURL: imageUrl, placeHolderImage: "mushroom_img")
        }
        if checkboxButton.isSelected {
            checkboxButton.setImage(UIImage(named: "checkbox_checked_icon"), for: .normal)
        }else {
            checkboxButton.setImage(UIImage(named: "checkbox_unchecked_icon"), for: .normal)
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
    
    func calculateHeight(for imageDetails: ImageDetails, width: CGFloat) -> CGFloat {
        let ratio = width / CGFloat(imageDetails.width ?? 0)
        let height = ratio * CGFloat(imageDetails.height ?? 0)
        return height
    }
    
    
    @IBAction func checkBoxButtonTapped(_ sender: Any) {
        checkboxButton.isSelected = !checkboxButton.isSelected
        if checkboxButton.isSelected {
            checkboxButton.setImage(UIImage(named: "checkbox_checked_icon"), for: .normal)
        }else {
            checkboxButton.setImage(UIImage(named: "checkbox_unchecked_icon"), for: .normal)
        }
    }
}

