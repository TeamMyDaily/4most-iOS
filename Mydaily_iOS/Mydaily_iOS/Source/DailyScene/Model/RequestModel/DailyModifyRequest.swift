//
//  DailyModifyRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/12.
//

import Foundation

struct DailyModifyRequest: Codable {
    var title: String
    var detail: String
    var satisfaction: Int
    
    init(_ title: String, _ detail: String, _ satis: Int) {
        self.title = title
        self.detail = detail
        self.satisfaction = satis
    }
}
