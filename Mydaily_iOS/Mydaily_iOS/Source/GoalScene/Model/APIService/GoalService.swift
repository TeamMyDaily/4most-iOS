//
//  GoalService.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/13.
//

import Foundation
import Moya

enum GoalService {
    case goalinquiry(param: GoalRequest)
    case goalwrite(param: GoalWriteRequest)
    case goalcomplete(Int)
    case goalmodify(param: GoalModifyRequest)
    case goaldelete(Int)
}

extension GoalService: TargetType {
    
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: GeneralAPI.baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .goalinquiry:
            return "/goals"
        case .goalwrite:
            return "/goals"
        case .goalcomplete(let goalID):
            return "/goals/completion/\(goalID)"
        case .goalmodify(let goalID):
            return "/goals/\(goalID)"
        case .goaldelete(let goalID):
            return "/goals/\(goalID)"
        }
    }
  
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .goalinquiry:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .goalinquiry:
            return .get
        case .goalwrite:
            return .post
        case .goalcomplete,
             .goalmodify:
            return .put
        case .goaldelete:
            return .delete
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .goalinquiry(let param):
            return .requestParameters(parameters: try! param.asDictionary(), encoding: URLEncoding.default)
        case .goalwrite(let param):
            return .requestJSONEncodable(param)
        case .goalcomplete,
             .goaldelete:
            return .requestPlain
        case .goalmodify(let param):
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
