//
//  GoalWriteModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

// MARK: - GoalWriteModel
struct GoalWriteModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: GoalInfo
}

// MARK: - GoalData
struct GoalInfo: Codable {
    let isGoalCompleted: Bool
    let id: Int
    let totalKeywordID, goal, date: String

    enum CodingKeys: String, CodingKey {
        case isGoalCompleted, id
        case totalKeywordID = "TotalKeywordId"
        case goal, date
    }
}

