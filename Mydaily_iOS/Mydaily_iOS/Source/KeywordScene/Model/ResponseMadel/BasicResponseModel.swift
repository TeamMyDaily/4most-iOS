//
//  BasicResponseMadel.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/13.
//
import Foundation

// MARK: - BasicResponseModel
struct BasicResponseModel: Codable {
    let status: Int
    let success: Bool
    let message: String
}
