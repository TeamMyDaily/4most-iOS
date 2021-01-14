//
//  SigninModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/11.
//

import Foundation

// MARK: - SigninModel
struct SigninModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SigninResponse
}

// MARK: - SigninResponse
struct SigninResponse: Codable {
    let userName, email, accessToken, refreshToken: String
}
