//
//  KeywordDefinitionRequest.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//

import Foundation
// MARK: - Welcome
struct KeywordDefinitionRequest: Codable {
    let name, definition: String
    
    init(name: String, definition: String){
        self.name = name
        self.definition = definition
    }
}
