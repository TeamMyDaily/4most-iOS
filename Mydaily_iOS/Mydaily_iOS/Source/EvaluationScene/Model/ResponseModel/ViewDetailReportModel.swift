//
//  ViewDetailReportModel.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - ViewDetailRetrospectiveModel
struct ViewDetailReportModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ViewDetailReportResponse
}

// MARK: - ViewDetailRetrospectiveResponse
struct ViewDetailReportResponse: Codable {
    let totalKeywordId: Int
    let keywordName: String
    let goal: String?
    let isGoalCompleted: Bool?
    let weekGoalId: Int?
    let goalExist: Bool
    let tasks: [Tasks]
}

// MARK: - Task
struct Tasks: Codable {
    let taskId: Int
    let title, date: String
    let satisfaction: Int

    enum CodingKeys: String, CodingKey {
        case taskId = "taskId"
        case title, date, satisfaction
    }
}
