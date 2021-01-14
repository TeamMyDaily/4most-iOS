//
//  GoalCompleteModel.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

// MARK: - GoalCompleteModel
struct GoalCompleteModel: Codable {
    let status: Int
    let success: Bool
    let message: String
}
