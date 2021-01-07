//
//  Extensions+Encodable.swift
//  placepic
//
//  Created by elesahich on 2020/09/26.
//  Copyright © 2020 elesahich. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

