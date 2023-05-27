//
//  ViewController.swift
//  PhotosApp
//
//  Created by Rajesab N Y on 27/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To set white background color
        view.backgroundColor = .white
        
        //To add an image view with your desired image in the center
        let imageView = UIImageView(image: UIImage(named: "mushroom_img"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20.0 // Set corner radius
        imageView.clipsToBounds = true // Clip to bounds for rounded corners
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor), // Square size
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Leading constraint
            view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20) // Trailing constraint
        ])
        
        
        animateImageView(imageView)
        //To delay navigation to the table view page after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.navigateToTableView()
        }
    }
    
    func navigateToTableView() {
        let tableViewController = TableViewController()
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    func animateImageView(_ imageView: UIImageView) {
        //To set initial transform values for scaling
        imageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        //To apply animation with duration
        UIView.animate(withDuration: 5.0,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                           // Reset the transform to its original state
                           imageView.transform = .identity
                       },
                       completion: nil)
    }
}

