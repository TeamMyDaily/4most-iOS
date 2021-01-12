//
//  DailyWriteRequest.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/12.
//

import Foundation

struct DailyWriteRequest: Codable {
    var totalKeywordId: Int
    var title: String
    var detail: String
    var satisfaction: Int
    
    init(_ id: Int, _ title: String, _ detail: String, _ satis: Int) {
        self.totalKeywordId = id
        self.title = title
        self.detail = detail
        self.satisfaction = satis
    }
}
