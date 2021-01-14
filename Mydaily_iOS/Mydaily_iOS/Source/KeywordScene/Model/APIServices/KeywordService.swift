//
//  KeywordService.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/12.
//

import Foundation
import Moya

enum KeywordServices{
    case addKeyword(param: AddKeywordRequest)
    case selectedKeywords(param: SelectedKeywordsRequest)
    case priorityKeyword(param: PriorityKeywordRequest)
    case keywordDefinition(param: KeywordDefinitionRequest)
}

extension KeywordServices: TargetType{
    
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self{
        case .addKeyword:
            return "/keywords/new"
        case .selectedKeywords:
            return "/keywords"
        case .priorityKeyword:
            return "/keywords/priority"
        case .keywordDefinition:
            return "/keywords/definition"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addKeyword,
             .selectedKeywords,
             .priorityKeyword,
             .keywordDefinition:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .addKeyword(let param):
            return .requestJSONEncodable(param)
        case .selectedKeywords(let param):
            return .requestJSONEncodable(param)
        case .priorityKeyword(let param):
            return .requestJSONEncodable(param)
        case .keywordDefinition(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json", "jwt": GeneralAPI.token]
        }
    }
    
}
