//
//  ViewReportModel.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - ViewReportModel
struct ViewReportModel: Codable {
    let status: Int
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let keywordsExist: Bool
    let result: [Results]
}

// MARK: - Result
struct Results: Codable {
    let totalKeywordID: Int
    let keyword: String
    let weekGoal: String?
    let taskCnt: Int
    let taskSatisAvg: String

    enum CodingKeys: String, CodingKey {
        case totalKeywordID = "totalKeywordId"
        case keyword, weekGoal, taskCnt, taskSatisAvg
    }
}
