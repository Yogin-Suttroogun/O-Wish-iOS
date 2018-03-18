//
//  Constants.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 16/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import Foundation

let BASE_URL = "http://192.168.100.3:8080/"
let CHECK_USER_URL = "users/"
let CHECK_ADMIN_URL = "admins/"
let POST_NEW_USER_URL = "newUser"

let headersKeyValue = [
    "Content-Type": "application/json",
    "Accept" : "application/json"
]

typealias DownloadComplete = () -> ()

let CHECK_VALIDITY_USER = "\(BASE_URL)\(CHECK_USER_URL)"
let CHECK_VALIDITY_ADMIN = "\(BASE_URL)\(CHECK_ADMIN_URL)"
let POST_NEW_USER = "\(BASE_URL)\(CHECK_USER_URL)\(POST_NEW_USER_URL)"


