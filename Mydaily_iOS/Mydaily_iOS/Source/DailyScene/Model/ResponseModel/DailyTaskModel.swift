//
//  DailyTaskModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/12.
//

import Foundation

// MARK: - DailyTaskModel
struct DailyTaskModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: TaskDetail
}

// MARK: - TaskDetail
struct TaskDetail: Codable {
    let id, totalKeywordID: Int
    let title, detail: String
    let satisfaction: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case id
        case totalKeywordID = "TotalKeywordId"
        case title, detail, satisfaction, date
    }
}
