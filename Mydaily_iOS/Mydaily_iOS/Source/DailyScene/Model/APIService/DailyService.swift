//
//  DailyService.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/12.
//

import Foundation
import Moya

enum DailyService {
    case dailyinquiry(String)
    case dailytask(Int)
    case dailyWrite(param: DailyWriteRequest)
    case dailyModify(param: DailyModifyRequest)
}

extension DailyService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .dailyinquiry(let date):
            return "/tasks" + date
        case .dailytask(let id):
            return "/tasks/\(id)"
        case .dailyWrite:
            return "/tasks"
        case .dailyModify(let id):
            return "/tasks/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .dailyinquiry,
             .dailytask:
            return .get
        case .dailyWrite:
            return .post
        case .dailyModify:
            return .put
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .dailyinquiry,
             .dailytask:
            return .requestPlain
        case .dailyWrite(let param):
            return .requestJSONEncodable(param)
        case .dailyModify(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwibmFtZSI6InFxIiwiZW1haWwiOiJxcUBxcS5xcSIsImlhdCI6MTYxMDMzMzQ0MywiZXhwIjoxNjEyOTI1NDQzLCJpc3MiOiJjeWoifQ.k3HAJg9K_NMVscJWafGBdCB4Odj6qua9VUL2N3_siYo"
            ]
        }
    }
}
