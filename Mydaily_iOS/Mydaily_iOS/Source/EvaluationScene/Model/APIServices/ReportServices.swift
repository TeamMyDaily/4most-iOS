//
//  ReportService.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation
import Moya

enum ReportServices {
    case viewReport(param: ViewRequest)
    case viewRetrospective(param: ViewRequest)
    case registRetrospective(param: RegistRetrospectiveRequest)
    case viewDetailReport(param: ViewDetailReportRequest)
}

extension ReportServices: TargetType {
  public var baseURL: URL {
    return URL(string: GeneralAPI.baseURL)!
  }
  
  var path: String {
    switch self {
    case .viewReport( _):
        return "/reports"
    case .viewRetrospective( _):
        return "/reviews"
    case .registRetrospective:
        return "/reviews"
    case .viewDetailReport( _):
        return "/reports/detail"
    }
  }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .viewRetrospective,
             .viewReport:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
  
  var method: Moya.Method {
    switch self {
    case .viewReport,
         .viewRetrospective:
        return .get
    case .registRetrospective,
         .viewDetailReport:
        return .post
    }
  }
  
  var sampleData: Data {
    return "@@".data(using: .utf8)!
  }
  
  var task: Task {
    switch self {
    case .viewReport(let param):
        return .requestParameters(parameters: try! param.asDictionary(), encoding: URLEncoding.default)
    case .viewRetrospective(let param):
        return .requestParameters(parameters: try! param.asDictionary(), encoding: URLEncoding.default)
    case .registRetrospective(let param):
        return .requestJSONEncodable(param)
    case .viewDetailReport(let param):
        return .requestJSONEncodable(param)
    }
  }

  var headers: [String: String]? {
    switch self {
    default:
        let accessToken = UserDefaultStorage.accessToken
      return ["Content-Type": "application/json",
              "jwt" : accessToken]
    }
  }
}
