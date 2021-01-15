//
//  GoalModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

// MARK: - GoalModel
struct GoalModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: GoalData
}

// MARK: - GoalData
struct GoalData: Codable {
    let keywordsExist: Bool
    let result: GoalResult?
}

// MARK: - Result
struct GoalResult: Codable {
    let count, notSetGoalCount: Int
    let keywords: [GoalKeyword]?
}

// MARK: - Keyword
struct GoalKeyword: Codable {
    var totalKeywordID, priority: Int?
    var name: String
    var isGoalCreated: Bool
    var weekGoalID: Int?
    var weekGoal: String?
    var isGoalCompleted: Bool?

    enum CodingKeys: String, CodingKey {
        case totalKeywordID = "totalKeywordId"
        case priority, name, isGoalCreated
        case weekGoalID = "weekGoalId"
        case weekGoal, isGoalCompleted
    }
}
