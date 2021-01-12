//
//  ViewDetailReportRequest.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

struct ViewDetailReportRequest: Codable {
    let totalKeywordID: String
    let start: String?
    let end: String?

    init(_ keywordID: String, _ start: String, _ end: String) {
        self.totalKeywordID = keywordID
        self.start = start
        self.end = end
    }
}
