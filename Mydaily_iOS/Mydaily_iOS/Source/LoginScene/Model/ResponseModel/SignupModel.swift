//
//  SignupModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/11.
//

import Foundation

// MARK: - SignupModel
struct SignupModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LoginResponse
}

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let email, userName: String
}
