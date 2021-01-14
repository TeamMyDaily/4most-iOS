//
//  SelectedKeywordResponse.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation

// MARK: - SelectedKeywordsModel
struct SelectedKeywordsModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [SelectedKeywordsResponse]
}

// MARK: - SelectedKeywordsResponse
struct SelectedKeywordsResponse: Codable {
    let date: String
    let id, totalKeywordID: Int
}
