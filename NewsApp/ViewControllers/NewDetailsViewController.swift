//
//  NewViewController.swift
//  NewsApp
//
//  Created by Diana Ovechkina on 20.01.2022.
//

import UIKit

class NewDetailsViewController: UIViewController {
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var newImage: UIImageView!
    
    var newInfo: New!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newInfo.title
        descriptionLabel.text = newInfo.description
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.newInfo.urlToImage) else { return }
            DispatchQueue.main.async {
                self.newImage.image = UIImage(data: imageData)
    
            }
        }
    }
    
}
