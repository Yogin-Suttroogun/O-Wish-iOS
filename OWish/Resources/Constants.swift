//
//  Constants.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 16/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import Foundation

// Chang to your ip address
let BASE_URL = "http://192.168.100.3:8080/"
let CHECK_USER_URL = "users/"
let CHECK_ADMIN_URL = "admins/"
let POST_NEW_USER_URL = "newUser"
let PRODUCTS = "products"
let RESET_PASSWORD_URL = "resetPassword"
let NEW_ITEM_URL = "/newItem"
let UPDATE_ITEM_URL = "/updateItem"
let DELETE_ITEM_URL = "/deleteItem"

let headersKeyValue = [
    "Content-Type": "application/json",
    "Accept" : "application/json"
]

typealias DownloadComplete = () -> ()

let CHECK_VALIDITY_USER = "\(BASE_URL)\(CHECK_USER_URL)"
let CHECK_VALIDITY_ADMIN = "\(BASE_URL)\(CHECK_ADMIN_URL)"
let POST_NEW_USER = "\(BASE_URL)\(CHECK_USER_URL)\(POST_NEW_USER_URL)"
let GET_PRODUCT = "\(BASE_URL)\(PRODUCTS)"
let RESET_PASSWORD = "\(BASE_URL)\(CHECK_USER_URL)\(RESET_PASSWORD_URL)"
let NEW_ITEM = "\(BASE_URL)\(PRODUCTS)\(NEW_ITEM_URL)"
let UPDATE_ITEM = "\(BASE_URL)\(PRODUCTS)\(UPDATE_ITEM_URL)"
let DELETE_ITEM = "\(BASE_URL)\(PRODUCTS)\(DELETE_ITEM_URL)"



