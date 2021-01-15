//
//  Login.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/15.
//

import Foundation
import UIKit

class Login: NSObject {
    static let shared = Login()
    let login = "isLogin"
    
    // MARK: - LOGIN
    func isLogin() -> Bool {
        let def = UserDefaults.standard
        let flag = def.bool(forKey: login)
        
        return flag
    }
    
    func setLogin(name:String, token: String) {
        let def = UserDefaults.standard
        UserData.set(token, forKey: .accessToken)
        UserData.set(name, forKey: .userName)
        
        def.set(true, forKey: login)
        def.synchronize()
    }
    
    func setLoginOut() {
        let def = UserDefaults.standard
        
        UserData<Any>.clearAll()
        
        def.set(false, forKey: login)
        def.synchronize()
        
        let rootVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
