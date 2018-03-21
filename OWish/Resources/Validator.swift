//
//  Validator.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 15/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class Validator: NSObject {
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValidate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailValidate.evaluate(with: email)
    }
    
    /*
     at least one uppercase,
     at least one digit
     at least one lowercase
     8 characters total
     */
    func isPasswordValid(password:String) -> Bool {
        let pwdRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordValidate = NSPredicate(format: "SELF MATCHES %@", pwdRegEx)
        return passwordValidate.evaluate(with: password)
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
    
    func isAlphaNumeric(string : String) -> Bool{
        let AlphaRegEx = "^[a-zA-Z0-9\\s.]{1,}$"
        let validateAlphaRegEx = NSPredicate(format: "SELF MATCHES %@", AlphaRegEx)
        return validateAlphaRegEx.evaluate(with: string)
    }
    
    func isPositiveInteger(integerValue: String) -> Bool {
        let numberRegEx = "[1-9][0-9]{0,}"
        let numberToValidate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return numberToValidate.evaluate(with: integerValue)
    }
    
}
