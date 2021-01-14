//
//  GoalRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation

struct GoalRequest: Codable {
    let start: String?
    let end: String?
    
    init(_ startdate: String,_ enddate: String) {
        self.start = startdate
        self.end = enddate
    }
}
