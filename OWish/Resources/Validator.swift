//
//  Validator.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 15/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class Validator: NSObject {
    func isValidEmail(emailVal:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailVal)
    }
    
    /*
     at least one uppercase,
     at least one digit
     at least one lowercase
     8 characters total
     */
    func isPasswordValid(pwdVal:String) -> Bool {
        let pwdRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", pwdRegEx)
        return passwordTest.evaluate(with: pwdVal)
    }
    
    /*
     checks if text has min 8 chars
     */
    
    func checkTextLength(text: String) -> Bool {
        return text.characters.count >= 8 ? true : false
    }
    
    /*
     checks name validity
     return true if name is valid
     */
    func isValidName(string:String) -> Bool {
        let emailRegEx = "[A-zÀ-ÿ ]+"
        
        let emailValidate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailValidate.evaluate(with: string)
    }
}
