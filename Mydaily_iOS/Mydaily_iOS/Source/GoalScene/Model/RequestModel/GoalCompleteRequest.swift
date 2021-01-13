//
//  GoalCompleteRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

struct GoalCompleteRequest: Codable {
    let date: String?
    
    init(_ date: String) {
        self.date = date
    }
}
