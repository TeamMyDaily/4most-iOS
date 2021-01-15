//
//  RegisterRecordKeywordModel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/14.
//

import Foundation

// MARK: - Welcome
struct RegisterRecordKeywordModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [RegisterRecordKeyword]
}

// MARK: - Datum
struct RegisterRecordKeyword: Codable {
    let id, TotalKeywordId: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case id
        case TotalKeywordId
        case date
    }
}
