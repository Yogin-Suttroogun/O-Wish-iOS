//
//  ItemDetailsVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 12/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {
    
    @IBOutlet weak var itemImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 200/255.0, green: 5/255.0, blue: 5/255.0, alpha: 0.5)
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
    
}

