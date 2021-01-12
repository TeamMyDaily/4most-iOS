//
//  RegistRetrospectiveModel.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - RegistRetrospectiveModel
struct RegistRetrospectiveModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: RegistRetrospectiveResponse
}

// MARK: - RegistRetrospectiveResponse
struct RegistRetrospectiveResponse: Codable {
    let good, bad, next: String
}
