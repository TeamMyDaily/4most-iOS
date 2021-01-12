//
//  ReportService.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/12.
//

import Foundation
import Moya

enum ReportServices {
//    case viewReport
    case viewRetrospective
    case registRetrospective(param: RegistRetrospectiveRequest)
    case viewDetailReport(param: ViewDetailReportRequest)
}

extension ReportServices: TargetType {
  public var baseURL: URL {
    return URL(string: GeneralAPI.baseURL)!
  }
  
  var path: String {
    switch self {
    case .viewRetrospective:
        return "/reviews?start=\(String(describing: Date().startOfWeek))&end=\(String(describing: Date().endOfWeek))"
    case .registRetrospective:
        return "/reviews"
    case .viewDetailReport:
        return "/reports/detail?start=\(String(describing: Date().startOfWeek))&end=\(String(describing: Date().endOfWeek))"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .viewRetrospective:
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
    case .viewRetrospective:
        return .requestPlain
    case .registRetrospective(let param):
        return .requestJSONEncodable(param)
    case .viewDetailReport(let param):
        return .requestJSONEncodable(param)
    }
  }

  var headers: [String: String]? {
    switch self {
    default:
      return ["Content-Type": "application/json",
              "jwt" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwibmFtZSI6IuyLoOycpOyVhCIsImVtYWlsIjoidGxzZGJzZGswNTI1MEBnbWFpbC5jb20iLCJpYXQiOjE2MTAzNjcwMDQsImV4cCI6MTYxMDk3MTgwNCwiaXNzIjoiY3lqIn0.wAXvkP0ivT4aQ7uQ-hBxOGUEEsnLhOaa6sqDHJSghVo"]
    }
  }
}
