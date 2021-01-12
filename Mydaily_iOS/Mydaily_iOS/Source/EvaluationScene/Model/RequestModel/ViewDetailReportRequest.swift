//
//  ViewDetailReportRequest.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

struct ViewDetailReportRequest: Codable {
    let totalKeywordID: String

    init(_ keywordID: String) {
        self.totalKeywordID = keywordID
    }
}
