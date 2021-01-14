//
//  ViewRetrospectiveRequest.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation

struct ViewRequest: Codable {
    let start: String?
    let end: String?
    
    init(_ start: String, _ end: String) {
        self.start = start
        self.end = end
    }
}
