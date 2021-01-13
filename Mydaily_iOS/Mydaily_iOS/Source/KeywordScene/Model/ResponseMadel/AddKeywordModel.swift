//
//  AddKeywordModel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/12.
//

import Foundation

// MARK: - AddKeywordModel
struct AddKeywordModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AddKeywordResponse
}

// MARK: - AddKeywordResponse
struct AddKeywordResponse: Codable {
    let keyword: String
}
