//
//  SelectedKeywordRequest.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation

// MARK: - SelectedKeywordsRequest
struct SelectedKeywordsRequest: Codable {
    let keywords: [String]
    
    init(list: [String]){
        keywords = list
    }
}


