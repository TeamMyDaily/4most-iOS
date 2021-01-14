//
//  MypageService.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation
import Moya

enum MypageService{
    case userRecordKeywords
    case userKeywordList
    case registerRecordKeywords(param: RegisterRecordKeywordRequest)
    case deleteKeyword(param: KeywordIdRequest)
    case getKeywordDefinition(param: KeywordIdRequest)
}

extension MypageService:TargetType{
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: GeneralAPI.baseURL)!
        }
    }
    
    var path: String {
        switch self{
        case .userRecordKeywords:
            return "/keywords/taskKeyword"
        case .userKeywordList:
            return "/keywords/keywordList"
        case .registerRecordKeywords:
            return "/keywords/taskKeyword"
        case .deleteKeyword:
            return "/keywords"
        case .getKeywordDefinition:
            return "/keywords/definition"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getKeywordDefinition:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        case .userRecordKeywords,
             .userKeywordList,
             .getKeywordDefinition:
            return .get
        case .registerRecordKeywords:
            return .post
        case .deleteKeyword:
            return .delete
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getKeywordDefinition(let param):
            return .requestParameters(parameters: try! param.asDictionary(), encoding: URLEncoding.default)
        case .userRecordKeywords,
             .userKeywordList:
            return .requestPlain
        case .registerRecordKeywords(let param):
            return .requestJSONEncodable(param)
        case .deleteKeyword(param: let param):
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
