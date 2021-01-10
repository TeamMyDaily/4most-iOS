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

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
            return gregorian.date(byAdding: .day, value: -5, to: monday)
        }else{
            return gregorian.date(byAdding: .day, value: 2, to: monday)
        }
    }
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
            return gregorian.date(byAdding: .day, value: 1, to: sunday)
        }else{
            return gregorian.date(byAdding: .day, value: 8, to: sunday)
        }
    }
    var containWeek: Int? {
        let gregorian = Calendar(identifier: .gregorian)
        let startOfMonth = gregorian.date(from: gregorian.dateComponents([.year, .month], from: self))
        let comp1 = gregorian.dateComponents([.weekday], from: startOfMonth!)

        print(comp1)
        guard let week = gregorian.date(from: gregorian.dateComponents([.day], from: self)) else { return nil }
    
        if comp1.weekday ?? 0 > 5{
            if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
                return Calendar.current.component(.weekOfMonth, from: gregorian.date(byAdding: .day, value: -1, to: week)!)
            }else{
                return Calendar.current.component(.weekOfMonth, from: gregorian.date(byAdding: .weekday, value: 0, to: week)!)
            }
        }
        else{
            if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
                return Calendar.current.component(.weekOfMonth, from: gregorian.date(byAdding: .day, value: -2, to: week)!)
            }else{
                return Calendar.current.component(.weekOfMonth, from: self)
            }
        }
    }
}

