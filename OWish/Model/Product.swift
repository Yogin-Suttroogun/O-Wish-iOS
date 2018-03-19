//
//  Product.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 18/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
import ObjectMapper

class Product {
    
    var _title: String!
    var _price: Int!
    var _description: String!
    var _picture: String!
    var _supplier: String!
    
    var title: String{
        if _title == nil{
            _title = ""
        }
        return _title
    }
    
    var price: Int{
        if _price == nil{
            _price = 0
        }
        return _price
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var picture: String{
        if _picture == nil{
            _picture = ""
        }
        return _picture
    }
    
    var supplier: String{
        if _supplier == nil{
            _supplier = ""
        }
        return _supplier
    }

    
    func downloadProductItem(completed: @escaping ([Product]) -> Void){
        var product: Product
        product = Product()
        var products = [Product]()
        
        let getProductURL = GET_PRODUCT
        Alamofire.request(getProductURL, method: .get)
            .validate()
            .responseJSON { (response) in
                let result = response.result
                if let dict = result.value as? [Dictionary<String, AnyObject>]{
                    if let title = dict[0]["title"] as? String{
                        product._title = String(title)
                    }
                    if let price = dict[0]["price"] as? Int{
                        product._price = price
                    }
                    if let description = dict[0]["description"] as? String{
                        product._description = description
                    }
                    if let picture = dict[0]["picture"] as? String{
                        product._picture = picture
                    }
                    if let supplier = dict[0]["supplier"] as? String{
                        product._supplier = supplier
                    }
                    
                    for obj in dict{
                        products.append(product)
                    }
                    completed(products)
                }
        }
        
    }
}
