//
//  DesignableButton.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 10/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
}

