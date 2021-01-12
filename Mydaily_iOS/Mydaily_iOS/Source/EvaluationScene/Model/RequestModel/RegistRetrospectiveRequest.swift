//
//  RegistRetrospectiveRequest.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

// MARK: - RegistRetrospectiveRequest
struct RegistRetrospectiveRequest: Codable {
    let start, end, now, subType: Int
    let content: String
    
    init(_ start: Int, _ end: Int, _ now: Int, _ subType: Int, _ content: String) {
        self.start = start
        self.end = end
        self.now = now
        self.subType = subType
        self.content = content
    }
}
