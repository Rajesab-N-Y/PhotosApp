//
//  LazyImageView.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 28/05/23.
//

import UIKit

class LazyImageView: UIImageView {
    
    private static let imageCache = NSCache<NSURL, UIImage>()

    private var imageURL: URL?
    private var placeHolderImage: String?

    func loadImage(fromURL imageURL: URL, placeHolderImage: String) {
        self.imageURL = imageURL
        self.placeHolderImage = placeHolderImage

        if let cachedImage = LazyImageView.imageCache.object(forKey: imageURL as NSURL) {
            debugPrint("Image loaded from cache for \(imageURL)")
            self.image = cachedImage
            return
        }

        self.image = UIImage(named: placeHolderImage)

        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                LazyImageView.imageCache.setObject(image, forKey: imageURL as NSURL)
                if imageURL == self?.imageURL {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

