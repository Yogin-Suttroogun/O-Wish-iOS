//
//  ItemDetailsVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 12/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit
import Alamofire

class ItemDetailsVC: UIViewController {
    
    @IBOutlet weak var itemImage: UIButton!
    @IBOutlet weak var titleTxtFld: DesignableTextField!
    @IBOutlet weak var priceTxtFld: DesignableTextField!
    @IBOutlet weak var descriptionTxtFld: DesignableTextField!
    @IBOutlet weak var supplierTxtFld: DesignableTextField!
    
    var itemToEdit: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 200/255.0, green: 5/255.0, blue: 5/255.0, alpha: 0.5)
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        if itemToEdit != nil{
            loadItemData()
        }
    }
    
    func loadItemData(){
        if let item = itemToEdit{
            titleTxtFld.text = item._title
            priceTxtFld.text = "$ \(item._price!)"
            descriptionTxtFld.text = item._description
            supplierTxtFld.text = item._supplier
            titleTxtFld.isUserInteractionEnabled = false
        }
    }
    
    
    @IBAction func save(_ sender: Any) {
        // Validation for all fields
        let isDescriptionValid = Validator().isValidName(string: descriptionTxtFld.text!)
        let isSupplierValid = Validator().isValidName(string: supplierTxtFld.text!)
        
        if !isDescriptionValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid description.")
            return
        }
        
        if !isSupplierValid{
            alertMessage(title: "Invalid", msg: "Please enter a valid supplier.")
            return
        }
        
        if itemToEdit == nil{
            postNewItem()
        } else{
            updateExistingItem()
        }
        
    }
    
    func postNewItem(){
        let postNewItemURL = NEW_ITEM
        let params = [
            "title":titleTxtFld.text!,
            "price":priceTxtFld.text!,
            "description":descriptionTxtFld.text!,
            "picture":"",
            "supplier":supplierTxtFld.text!,
        ] as [String: Any]
        
        Alamofire.request(postNewItemURL, method: .post, parameters: params, encoding: JSONEncoding.default , headers: headersKeyValue)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                if resultValue {
                    //perform navigation
                    
                    let alert = UIAlertController(title: "Success", message: "One item has been successfully inserted.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                        self.performSegue(withIdentifier: "adminConsole", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.alertMessage(title: "Invalid", msg: "An error has occured. Please try again later.")
                }
        }
        
    }
    
    func updateExistingItem(){
        let updateItemURL = UPDATE_ITEM
        let priceString: String = (priceTxtFld.text?.replacingOccurrences(of: "$", with: ""))!
        let params = [
            "title":titleTxtFld.text!,
            "price":priceString,
            "description":descriptionTxtFld.text!,
            "picture":"",
            "supplier":supplierTxtFld.text!,
            ] as [String: Any]
        
        Alamofire.request(updateItemURL, method: .put, parameters: params, encoding: JSONEncoding.default , headers: headersKeyValue)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                if resultValue {
                    //perform navigation
                    
                    let alert = UIAlertController(title: "Success", message: "Your item has been updated!", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                        self.performSegue(withIdentifier: "adminConsole", sender: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.alertMessage(title: "Invalid", msg: "An error has occured. Please try again later.")
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

extension ItemDetailsVC: UITextFieldDelegate {
    
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

