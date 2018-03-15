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
            if(!isValidEmail(emailVal: emailTxtFld.text!)){
                alertMessage(header: "Invalid", msg: "Please enter a valid email address.")
                return
            }else{
                if(!isPasswordValid(pwdVal: passwordTxtFld.text!)){
                    alertMessage(header: "Invalid", msg: "Please enter a valid password.")
                    return
                }
            }
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
    
    func alertMessage(header: String, msg: String) {
        // create the alert
        let alert = UIAlertController(title: header, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

