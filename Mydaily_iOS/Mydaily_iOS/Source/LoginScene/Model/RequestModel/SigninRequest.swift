//
//  SigninRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/11.
//

import Foundation

struct SigninRequest: Codable {
    var email: String
    var password: String
    
    init(_ email: String, _ pw: String) {
        self.email = email
        self.password = pw
    }
}
