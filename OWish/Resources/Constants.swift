//
//  Constants.swift
//  OWish
//
//  Created by SUTTROOGUN Yogin Kumar on 16/03/2018.
//  Copyright © 2018 SUTTROOGUN Yogin Kumar. All rights reserved.
//

import Foundation

let BASE_URL = "http://192.168.100.3:8080/"
let CHECK_USER_EMAIL_URL = "users/"
let CHECK_ADMIN_EMAIL_URL = "admins/"

typealias DownloadComplete = () -> ()

let CHECK_VALIDITY_USER = "\(BASE_URL)\(CHECK_USER_EMAIL_URL)"
let CHECK_VALIDITY_ADMIN = "\(BASE_URL)\(CHECK_ADMIN_EMAIL_URL)"


