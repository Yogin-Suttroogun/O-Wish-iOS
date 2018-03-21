//
//  ItemCell.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 19/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    func configureCell(product: Product){
        itemTitle.text = "\(product._title!)"
        itemPrice.text = "\(product._price!)"
        itemDescription.text = "\(product._description!)"
        
        if let decodedData = Data(base64Encoded: product._picture, options: .ignoreUnknownCharacters){
            let image = UIImage(data: decodedData)
            itemImage.image = image
        }
    }
}
