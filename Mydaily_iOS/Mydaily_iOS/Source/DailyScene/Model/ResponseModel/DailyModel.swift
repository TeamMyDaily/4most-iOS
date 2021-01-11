//
//  DailyModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/12.
//

import Foundation

// MARK: - DailyModel
struct DailyModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Keyword
}

// MARK: - Keyword
struct Keyword: Codable {
    let keywordsExist: Bool
    let result: [KeywordData]
}

// MARK: - Result
struct KeywordData: Codable {
    let totalKeywordID, priority: Int
    let name: String
    let tasks: [task]

    enum CodingKeys: String, CodingKey {
        case totalKeywordID = "TotalKeywordId"
        case priority, name, tasks
    }
}

// MARK: - task
struct task: Codable {
    let id: Int
    let title: String
}
