//
//  ItemDetailsVC.swift
//  O'Wish
//
//  Created by SUTTROOGUN Yogin Kumar on 12/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import UIKit
import Alamofire

class ItemDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleTxtFld: DesignableTextField!
    @IBOutlet weak var priceTxtFld: DesignableTextField!
    @IBOutlet weak var descriptionTxtFld: DesignableTextField!
    @IBOutlet weak var supplierTxtFld: DesignableTextField!
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
    var itemToEdit: Product?
    var imagePicker: UIImagePickerController!
    var encodedString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 200/255.0, green: 5/255.0, blue: 5/255.0, alpha: 0.5)
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
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
            
            if let decodedData = Data(base64Encoded: item._picture, options: .ignoreUnknownCharacters){
                let image = UIImage(data: decodedData)
                itemImage.image = image
            }
        }
    }
    
    func startLoading(){
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        view.addSubview(activityIndicator);
        
        activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
    }
    
    func stopLoading(){
        activityIndicator.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents();
    }
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            itemImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func encodeImage(img: UIImage?){
        let imageData:NSData = UIImagePNGRepresentation(img!)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        encodedString = strBase64
    }
    
    @IBAction func save(_ sender: Any) {
        // Validation for all fields
        let isTitleValid = Validator().isAlphaNumeric(string: titleTxtFld.text!)
        let isPriceValid = Validator().isPositiveInteger(integerValue: priceTxtFld.text!)
        let isDescriptionValid = Validator().isValidName(string: descriptionTxtFld.text!)
        let isSupplierValid = Validator().isValidName(string: supplierTxtFld.text!)
        
        if !isTitleValid{
            alertMessage(title: "Invalid", msg: "Please enter a valid title")
            return
        }
        
        if !isPriceValid{
            alertMessage(title: "Invalid", msg: "Please enter a valid price.")
            return
        }
        
        if !isDescriptionValid {
            alertMessage(title: "Invalid", msg: "Please enter a valid description.")
            return
        }
        
        if !isSupplierValid{
            alertMessage(title: "Invalid", msg: "Please enter a valid supplier.")
            return
        }
        
        if itemToEdit == nil{
            startLoading()
            checkProductTitleExistance()
        } else{
            startLoading()
            updateExistingItem()
        }
        
    }
    
    func checkProductTitleExistance(){
        var handlingWhiteSpaces: String
        if (titleTxtFld.text == nil || titleTxtFld.text == " "){
            handlingWhiteSpaces = " "
        } else{
            handlingWhiteSpaces = (self.titleTxtFld.text?.replacingOccurrences(of: " ", with: "%20"))!
        }
        
        let productTitleURL = "\(GET_PRODUCT)/\(handlingWhiteSpaces)"
        Alamofire.request(productTitleURL, method: .get)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                if resultValue{
                    self.stopLoading()
                    self.alertMessage(title: "Invalid", msg: "Product title already exist. Please enter another one.")
                }else{
                    self.postNewItem()
                }
        }
    }
    
    func postNewItem(){
        let postNewItemURL = NEW_ITEM
        encodeImage(img: itemImage.image)
        let params = [
            "title":titleTxtFld.text!,
            "price":priceTxtFld.text!,
            "description":descriptionTxtFld.text!,
            "picture":encodedString,
            "supplier":supplierTxtFld.text!,
        ] as [String: Any]
        
        Alamofire.request(postNewItemURL, method: .post, parameters: params, encoding: JSONEncoding.default , headers: headersKeyValue)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                self.stopLoading()
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
        encodeImage(img: itemImage.image)
        let params = [
            "title":titleTxtFld.text!,
            "price":priceString,
            "description":descriptionTxtFld.text!,
            "picture":encodedString,
            "supplier":supplierTxtFld.text!,
            ] as [String: Any]
        
        Alamofire.request(updateItemURL, method: .put, parameters: params, encoding: JSONEncoding.default , headers: headersKeyValue)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                self.stopLoading()
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
    
    @IBAction func deleteItem(_ sender: Any) {
        self.startLoading()
        
        let deleteItemURL = "\(DELETE_ITEM)/\(titleTxtFld.text!)"
        Alamofire.request(deleteItemURL, method: .delete)
            .validate()
            .responseJSON { (response) in
                let resultValue = response.result.value! as! Bool
                self.stopLoading()
                if resultValue{
                    //perform navigation
                    let alert = UIAlertController(title: "Success", message: "Your item has been deleted!", preferredStyle: UIAlertControllerStyle.alert)
                    
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

