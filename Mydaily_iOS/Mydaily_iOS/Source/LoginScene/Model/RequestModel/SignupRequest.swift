//
//  SignupRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/11.
//

import Foundation

struct SignupRequest {
    var email: String
    var password: String
    var passwordConfirm: String
    var userName: String
    
    init(_ email: String, _ pw: String, _ pwconfirm: String, _ user: String) {
        self.email = email
        self.password = pw
        self.passwordConfirm = pwconfirm
        self.userName = user
    }
}
