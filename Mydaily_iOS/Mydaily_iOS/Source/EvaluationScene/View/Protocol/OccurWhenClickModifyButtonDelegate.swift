//
//  ChangeModifyButtonDelegate.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/07.
//

import Foundation

protocol OccurWhenClickModifyButtonDelegate: class {
    func changeModifyButton(isActive: Bool)
    func showAlert(title: String, message: String)
}
