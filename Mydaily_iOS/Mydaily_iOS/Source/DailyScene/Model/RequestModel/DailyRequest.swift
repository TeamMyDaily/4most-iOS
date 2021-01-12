//
//  DailyRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/12.
//

import Foundation

struct DailyRequest: Codable {
    let date: String?
    
    init(_ date: String) {
        self.date = date
    }
}
