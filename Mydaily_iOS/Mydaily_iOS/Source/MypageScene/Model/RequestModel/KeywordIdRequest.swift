//
//  KeywordIdRequest.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/14.
//

import Foundation

// MARK: - RegisterRecordKeywordRequest
struct KeywordIdRequest: Codable {
    let totalKeywordId: Int

    enum CodingKeys: String, CodingKey {
        case totalKeywordId
    }
    
    init (totalKeywordId: Int){
        self.totalKeywordId = totalKeywordId
    }
}
