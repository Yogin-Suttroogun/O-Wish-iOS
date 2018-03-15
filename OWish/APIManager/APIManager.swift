//
//  APIManager.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 15/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol ResponseObjectSerializable {
    init?(json: JSON)
}

public protocol ResponseCollectionSerializable {
    static func collection(json: JSON) -> [Self]
}

public class Network {
  public static let sharedInstance = Network()
    
//    TODO: if need user create a model
//    public var currentUser: User?
    
    static let baseURLString = "http://localhost:8080/"
    static let userURLString = "users"
    
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    
//    API Calls
    public func login(email: String, password: String, success: @escaping (String)->()) -> Request? {
        let url:String = Network.baseURLString + Network.userURLString
        let params = [:] as [String: Any]
//        let headers = [String]()
        
        Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: [:])
            .validate()
            .responseJSON {response in
                if response.result.isSuccess {
                    print("SUCCESS")
                }else {
                    print("ERROR")
                }
        }
        return nil
    }
}


