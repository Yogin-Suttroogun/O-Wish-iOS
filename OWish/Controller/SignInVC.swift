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
//            if(!Validator.isValidEmail(emailVal: emailTxtFld.text!)){
//                alertMessage(header: "Invalid", msg: "Please enter a valid email address.")
//                return
//            }else{
//                if(!isPasswordValid(pwdVal: passwordTxtFld.text!)){
//                    alertMessage(header: "Invalid", msg: "Please enter a valid password.")
//                    return
//                }
//            }
            let isEmailValid = Validator().isValidEmail(email: emailTxtFld.text!)
            
            performSegue(withIdentifier: "userProfile", sender: nil)
        }
        
        //        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        //        spinner.startAnimating()
        
    }
    
    private func showAlert(alert: UIAlertController) {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //    TODO: Uncomment afterward when passing user information
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let userProfile = segue.destination as? FeedVC{
    //
    //        }else if let adminProfile = segue.destination as? AdminVC{
    //        }
    //    }
}

