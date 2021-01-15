//
//  UserData.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/15.
//

import Foundation

class UserDefaultStorage {
    static var accessToken: String {
        return UserData<String>.value(forKey: .accessToken) ?? "err"
    }
    
//    static var refreshToken: String {
//        return DataHelper<String>.value(forKey: .refreshToken) ?? "err"
//    }
    
    static var userName: String {
        return UserData<String>.value(forKey: .userName) ?? "err"
    }
    
    static var setKeyword: Bool {
        return UserData<Bool>.value(forKey: .setKeyword) ?? false
    }
}

enum DataKeys: String {
    case accessToken = "accessToken"
    case userName = "userName"
//    case refreshToken = "refreshToken"
    case setKeyword = "setKeyword"
}

class UserData<T> {
    class func value(forKey key: DataKeys) -> T? {
        if let data = UserDefaults.standard.value(forKey : key.rawValue) as? T {
            return data
        }
        else {
            return nil
        }
    }
    
    class func set(_ value: T, forKey key: DataKeys) {
        UserDefaults.standard.set(value, forKey : key.rawValue)
    }
    
    class func addObserver(_ observer: NSObject, forKey key: DataKeys, options: NSKeyValueObservingOptions) {
        addObserver(observer, forKeyPath: key.rawValue, options: options)
    }
    
    class func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions) {
        UserDefaults.standard.addObserver(observer, forKeyPath: keyPath, options: options, context: nil)
    }
    
    class func removeObserver(_ observer: NSObject, forKey key: DataKeys) {
        removeObserver(observer, forKeyPath: key.rawValue)
    }
    
    class func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        UserDefaults.standard.removeObserver(observer, forKeyPath: keyPath)
    }
    
    class func clearAll() {
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
