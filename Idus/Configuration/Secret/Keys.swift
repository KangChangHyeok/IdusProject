//
//  File.swift
//  Ideas
//
//  Created by 강창혁 on 2022/06/30.
//

import UIKit
import Alamofire

struct Keys {
    
    static let baseURL = "https://prod.idus-b.shop"
    
    static let headers: HTTPHeaders = [
                "Content-Type":"application/json",
                "Accept": "application/json"
            ]
    static let jwtHeaders: HTTPHeaders = [
        "Content-Type":"application/json",
        "Accept": "application/json",
        "X-ACCESS-TOKEN": "\(UserInfo.shared.jwt ?? "")"
    ]
}

