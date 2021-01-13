//
//  PriorityKeywordRequest.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation

// MARK: - PriorityKeywordRequest
struct PriorityKeywordRequest: Codable {
    let keywords: [PriorityKeyword]
    init(list: [PriorityKeyword]){
        keywords = list
    }
}

// MARK: - Keyword
struct PriorityKeyword: Codable {
    let name: String
    let priority: Int
}
