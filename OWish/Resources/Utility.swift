//
//  Utility.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 15/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    func alertMessage(controller: UIViewController, title: String, msg: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        controller.present(alert, animated: true, completion: nil)
    }

}
