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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        //To delay navigation to the table view page after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.navigateToTableView()
        }
    }
    
    func navigateToTableView() {
        let tableViewController = TableViewController()
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
}

