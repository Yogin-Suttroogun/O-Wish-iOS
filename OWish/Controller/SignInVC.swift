//
//  ViewController.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 07/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit
import Alamofire

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTxtFld: DesignableTextField!
    @IBOutlet weak var passwordTxtFld: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func login(_ sender: Any) {
        let isEmailValid = Validator().isValidEmail(email: emailTxtFld.text!)
        let isPasswordValid = Validator().isPasswordValid(password: passwordTxtFld.text!)
        
        if !isEmailValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid email address.")
            return
        }

        if !isPasswordValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid password.")
            return
        }
        
        //validating the credential for user and admin
        checkForCorrectUserLogin()
    }
    
    func alertMessage(title: String, msg: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //    API Calls
    func checkForCorrectUserLogin(){
        let checkUserURL = "\(CHECK_VALIDITY_USER)\(emailTxtFld.text!)/\(passwordTxtFld.text!)"
        Alamofire.request(checkUserURL, method: .get)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                if resultValue{
                    //perform navigation
                    self.performSegue(withIdentifier: "userProfile", sender: nil)
                }else{
                    // check validity for admin
                    self.checkForCorrectAdminLogin()
                }
        }
    }
    
    
    func checkForCorrectAdminLogin(){
        let checkAdminURL = "\(CHECK_VALIDITY_ADMIN)\(emailTxtFld.text!)/\(passwordTxtFld.text!)"
        Alamofire.request(checkAdminURL, method: .get)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                if resultValue{
                    //perform navigation
                    self.performSegue(withIdentifier: "adminProfile", sender: nil)
                }else{
                    self.alertMessage(title: "Invalid credentials", msg: "Please verify your email and password")
                }
        }
    }
    
    
}

extension SignInVC: UITextFieldDelegate {
    
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

