//
//  KeywordDefinitionModel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/14.
//

import Foundation

struct KeywordDefinitionModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: KeywordDefinition
}

// MARK: - DataClass
struct KeywordDefinition: Codable {
    let isWritten: Bool
    let name :String?
    let definition: String?
}
