//
//  Extensions+Date.swift
//  placepic
//
//  Created by elesahich on 2020/10/03.
//  Copyright © 2020 elesahich. All rights reserved.
//

import Foundation

extension Date {
  
  func timeAgoSinceDate() -> String {
    let fromDate = self
    let toDate = Date()
    if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
      return interval == 1 ? "\(interval)" + "년 전" : "\(interval)" + "년 전"
    }
    if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
      return interval == 1 ? "\(interval)" + "달 전" : "\(interval)" + "달 전"
    }
    if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
      return interval == 1 ? "\(interval)" + "일 전" : "\(interval)" + "일 전"
    }
    if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
      return interval == 1 ? "\(interval)" + "시간 전" : "\(interval)" + "시간 전"
    }
    if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
      return interval == 1 ? "\(interval)" + "분 전" : "\(interval)" + "분 전"
    }
    return "방금 전"
  }
}

