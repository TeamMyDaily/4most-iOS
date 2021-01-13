//
//  GoalModifyRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

struct GoalModifyRequest: Codable {
    let goal: String?
    
    init(_ data: String) {
        self.goal = data
    }
}
