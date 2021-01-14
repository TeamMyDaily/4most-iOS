//
//  PriorityKeywordModel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation

// MARK: - PriorityKeywordModel
struct PriorityKeywordModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [PriorityRegisterKeyword]
}

// MARK: - PriorityRegisterKeyword
struct PriorityRegisterKeyword: Codable {
    let id, totalKeywordID, priority: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case id
        case totalKeywordID
        case priority, date
    }
}
