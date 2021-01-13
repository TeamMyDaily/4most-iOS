//
//  MypageKeywordListModel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation

// MARK: - MypageKeywordListModel
struct MypageKeywordListModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [SelectedUserKeyword]
}

// MARK: - SelectedUserKeyword
struct SelectedUserKeyword: Codable {
    var totalKeywordId: Int
    var isSelected: Bool
    var name: String
    
    enum CodingKeys: String, CodingKey {
            case totalKeywordId
            case isSelected, name
    }
}

