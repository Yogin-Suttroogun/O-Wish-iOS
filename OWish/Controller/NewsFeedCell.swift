//
//  NewsFeedCell.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 21/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    
    func configureCell(product: Product){
        productTitle.text = "\(product._title!)"
        productDescription.text = "\(product._description!)"
        
        if let decodedData = Data(base64Encoded: product._picture, options: .ignoreUnknownCharacters){
            let image = UIImage(data: decodedData)
            productImage.image = image
        }
    }
    
}
