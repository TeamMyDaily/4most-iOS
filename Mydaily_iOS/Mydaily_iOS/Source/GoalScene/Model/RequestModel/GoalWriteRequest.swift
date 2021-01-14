//
//  GoalWriteRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

struct GoalWriteRequest: Codable {
    let startDate: Int?
    let totalKeywordId: Int?
    let goal: String?
    
    init(_ startdate: Int,_ keyword: Int,_ goal: String) {
        self.startDate = startdate
        self.totalKeywordId = keyword
        self.goal = goal
    }
}
