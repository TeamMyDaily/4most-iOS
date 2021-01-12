//
//  ViewDetailReportModel.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - ViewDetailRetrospectiveModel
struct ViewDetailRetrospectiveModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ViewDetailRetrospectiveResponse
}

// MARK: - ViewDetailRetrospectiveResponse
struct ViewDetailRetrospectiveResponse: Codable {
    let keywordName, goal: String
    let isGoalCompleted: Bool
    let tasks: [Task]
}

// MARK: - Task
struct Task: Codable {
    let taskID: Int
    let title, date: String
    let satisfaction: Int

    enum CodingKeys: String, CodingKey {
        case taskID = "taskId"
        case title, date, satisfaction
    }
}
