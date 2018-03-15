//
//  ViewController.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 07/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTxtFld: DesignableTextField!
    @IBOutlet weak var passwordTxtFld: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func login(_ sender: Any) {
        
        if(emailTxtFld.text! == "admin" && passwordTxtFld.text! == "admin"){
            performSegue(withIdentifier: "adminProfile", sender: nil)
        }else{
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
            
            
//            let _ = Network.sharedInstance.login(email: emailTxtFld.text!, password: passwordTxtFld.text!, success: { (response) in
//
//                print(response)
//            })
            
            performSegue(withIdentifier: "userProfile", sender: nil)
        }
        
        //        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        //        spinner.startAnimating()
        
    }
    
    //    TODO: Uncomment afterward when passing user information
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let userProfile = segue.destination as? FeedVC{
    //
    //        }else if let adminProfile = segue.destination as? AdminVC{
    //        }
    //    }
    
    func alertMessage(title: String, msg: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
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

