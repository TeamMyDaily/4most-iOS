//
//  MypageRecordKeywordModel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

// MARK: - MypageRecordKeywordModel
struct MypageRecordKeywordModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: UserRecordKeyword
}

// MARK: - DataClass
struct UserRecordKeyword: Codable {
    let keywords: [RecordKeywordData]
}

// MARK: - KeywordAndId
struct RecordKeywordData: Codable {
    var totalKeywordId: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case totalKeywordId
        case name
    }
}

//
//// MARK: - Welcome
//struct MypageRecordKeywordModel: Codable {
//    let status: Int
//    let success: Bool
//    let message: String
//    var data: RecordKeyword
//}
//
//// MARK: - DataClass
//struct RecordKeyword: Codable {
//    let keywords: [RecordKeywordData]
//}
//
//// MARK: - Keyword
//struct RecordKeywordData: Codable {
//    let totalKeywordID: Int
//    let name: String
//
//    enum CodingKeys: String, CodingKey {
//        case totalKeywordID
//        case name
//    }
//}

