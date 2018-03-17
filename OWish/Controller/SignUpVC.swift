//
//  SignUpVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 10/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController {
    
    @IBOutlet weak var emailTxtFld: DesignableTextField!
    @IBOutlet weak var fullNameTxtFld: DesignableTextField!
    @IBOutlet weak var passwordTxtFld: DesignableTextField!
    @IBOutlet weak var confirmPasswordTxtFld: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register(_ sender: Any) {
        let isFullNameValid = Validator().isValidName(string: fullNameTxtFld.text!)
        let isEmailValid = Validator().isValidEmail(email: emailTxtFld.text!)
        let isPasswordValid = Validator().isPasswordValid(password: passwordTxtFld.text!)
        
        if !isFullNameValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid name.")
            return
        }
        
        if !isEmailValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid email address.")
            return
        }
        
        checkEmailValidityForUser()
        
        if !isPasswordValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid password.")
            return
        }
        
        if passwordTxtFld.text! != confirmPasswordTxtFld.text! {
            alertMessage(title: "Mismatch", msg: "Please verify that your password and confirm password textfield is identical.")
            return
        }
        
        
        
    }
    
    //    API Calls
    func checkEmailValidityForUser(){
        let checkEmailURL = "\(CHECK_VALIDITY_USER)\(emailTxtFld.text!)"
        Alamofire.request(checkEmailURL, method: .get)
            .validate()
            .responseJSON{ response in
                let resultValue = response.result.value! as! Bool
                if resultValue {
                    self.alertMessage(title: "Invalid", msg: "Please enter a another email as this one is taken up.")
                }else{
                    //Post
                }
        }
    }
    
    func postNewUser(){
        
    }
    
    
    func alertMessage(title: String, msg: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SignUpVC: UITextFieldDelegate {
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

