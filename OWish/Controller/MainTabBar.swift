//
//  MainTabBar.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 21/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        let logOutBtn:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.reply, target: self, action: #selector(AdminVC.back))
        self.navigationItem.leftBarButtonItem = logOutBtn
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(displayP3Red: 200/255.0, green: 5/255.0, blue: 5/255.0, alpha: 0.5)
    }
    
    func back(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Log out", message: "Are you sure you want to exit the app?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "logOutUser", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
