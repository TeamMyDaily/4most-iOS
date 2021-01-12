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
    
    var todayOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let today = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: today)
    }
    
    var containWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let startOfMonth = gregorian.date(from: gregorian.dateComponents([.year, .month], from: self))
        let nextMonth = gregorian.date(byAdding: .month, value: 1, to: self)
        let nextStartOfMonth = gregorian.date(from: gregorian.dateComponents([.year, .month], from: nextMonth!))
        let comp1 = gregorian.dateComponents([.weekday], from: startOfMonth!)

        if comp1.weekday ?? 0 > 5{ //시작주가 목요일 이후부터 시작할때 (첫주 과반수가 저번달일때)
            if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
                if Calendar.current.component(.weekOfMonth, from: self) == 2 { //시작주 일요일일때
                    print("1")
                   return gregorian.date(byAdding: .weekOfMonth, value: -1, to: self)
                }
                else if Calendar.current.component(.weekOfMonth, from: self) == 3{ //시작주 다음주 일요일일때
                    print("2")
                    return gregorian.date(byAdding: .weekOfMonth, value: 0, to: startOfMonth!)
                }
                else{ //나머지
                    print("3")
                    return gregorian.date(byAdding: .weekOfMonth, value: -2, to: self)
                }
            }else{ //일요일 이외의 요일일때
                if Calendar.current.component(.weekOfMonth, from: self) == 2{ //시작주 요일일때
                    print("4")
                    return gregorian.date(byAdding: .weekOfMonth, value: 0, to: startOfMonth!)
                }
                else{ //시작주 이외의 요일일때
                    //문제
                    if Calendar.current.component(.weekOfMonth, from: self) == 6 && Calendar.current.component(.weekday, from: self) < 5{
                        print("5") //문제
                        return gregorian.date(byAdding: .weekOfMonth, value: 0, to: nextStartOfMonth!)
                    }
                    else{
                        print("5-1")
                        return gregorian.date(byAdding: .weekOfMonth, value: -1, to: startOfWeek!)
                    }
                }
            }
        }
        else{ //시작주가 목요일 이전부터 시작할때 (첫주 과반수가 이번달일때)
            if Calendar.current.component(.weekday, from: self) == 1{ //일요일일때
                if Calendar.current.component(.weekOfMonth, from: self) == 2 { //시작주 일요일일때
                    print("6")
                    return gregorian.date(byAdding: .weekOfMonth, value: 0, to: startOfMonth!)
                }
                else {
                    print("7")
                    return gregorian.date(byAdding: .weekOfMonth, value: -1, to: self)
                }
            }else{
                if Calendar.current.component(.weekOfMonth, from: self) == 5 && Calendar.current.component(.weekday, from: self) < 5{
                    print("8") //문제
                    return gregorian.date(byAdding: .weekOfMonth, value: 0, to: startOfWeek!)
                }
                else{
                    print("9")
                    return gregorian.date(byAdding: .weekOfMonth, value: 0, to: self)
                }
            }
        }
    }
}

