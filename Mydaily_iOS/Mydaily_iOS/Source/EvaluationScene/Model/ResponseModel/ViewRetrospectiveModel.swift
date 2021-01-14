//
//  ViewRetrospectiveModel.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - ViewRetrospectiveModel
struct ViewRetrospectiveModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ViewRetrospectiveResponse
}

// MARK: - ViewRetrospectiveResponse
struct ViewRetrospectiveResponse: Codable {
    let isWritten: Bool
    let review: Review
}

// MARK: - Review
struct Review: Codable {
    let good, bad, next: String
}
