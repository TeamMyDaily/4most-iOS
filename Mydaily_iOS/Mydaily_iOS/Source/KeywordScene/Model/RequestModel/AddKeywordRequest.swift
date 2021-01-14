//
//  AddKeyword.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/12.
//

import Foundation

struct AddKeywordRequest: Codable{
    var name: String
    
    init(keyword: String) {
        name = keyword
    }
}
