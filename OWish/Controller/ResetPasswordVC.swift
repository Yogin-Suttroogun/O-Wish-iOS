//
//  ResetPasswordVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 11/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit
import Alamofire

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTxtFld: DesignableTextField!
    @IBOutlet weak var passwordTxtFld: DesignableTextField!
    @IBOutlet weak var newPasswordTxtFld: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        let isEmailValid = Validator().isValidEmail(email: emailTxtFld.text!)
        let isPasswordValid = Validator().isPasswordValid(password: passwordTxtFld.text!)
        let isNewPasswordValid = Validator().isPasswordValid(password: newPasswordTxtFld.text!)
        
        if !isEmailValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid email address.")
            return
        }
        
        if !isPasswordValid {
            alertMessage(title: "Invalid", msg: "Please enter an actual valid password.")
            return
        }
        
        if !isNewPasswordValid{
            alertMessage(title: "Invalid", msg: "Please enter a new valid password.")
            return
        }
        
        checkEmailExist()
    }
    
    func checkEmailExist(){
        let checkEmailURL = "\(CHECK_VALIDITY_USER)\(emailTxtFld.text!)"
        Alamofire.request(checkEmailURL, method: .get)
            .validate()
            .responseJSON{ response in
                let resultValue = response.result.value! as! Bool
                if resultValue {
                    //Update
                    self.updatePassword()
                }else{
                    self.alertMessage(title: "Invalid", msg: "Please enter a valid email.")
                }
        }
    }
    
    func updatePassword(){
        let resetPasswordURL = RESET_PASSWORD
        let params = [
            "email": emailTxtFld.text!,
            "password": passwordTxtFld.text!,
            "newPassword": newPasswordTxtFld.text!
        ] as [String: Any]
        
        Alamofire.request(resetPasswordURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headersKeyValue)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                if(resultValue){
                    self.performSegue(withIdentifier: "userProfile", sender: nil)
                }else{
                    self.alertMessage(title: "Invalid", msg: "Please verify if your email and actual password are valid")
                }
        }
        
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

extension ResetPasswordVC: UITextFieldDelegate {
    
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

