//
//  RegistRetrospectiveRequest.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - RegistRetrospectiveRequest
struct RegistRetrospectiveRequest: Codable {
    let start, end, now: Int64
    let subType: Int
    let content: String
    
    init(_ start: Int64, _ end: Int64, _ now: Int64, _ subType: Int, _ content: String) {
        self.start = start
        self.end = end
        self.now = now
        self.subType = subType
        self.content = content
    }
}
