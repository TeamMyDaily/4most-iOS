//
//  AppDelegate.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/29.
//

import UIKit

protocol UserIdentifyInterface {
    func checkUserToken()
    func setUserToken()
}

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUserToken()
        checkUserToken()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    
}

extension AppDelegate: UserIdentifyInterface {
    func setUserToken() {
        //
    }
    
    func checkUserToken() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if Login.shared.isLogin() {
            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(identifier: "TabbarController")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else {
            let initialViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func setUserToken(token: String,name: String) {
        //    UserDefaults.standard.removeObject(forKey: "accessToken")
        //            LoginManager.shared.setLoginOut()
        let accessToken = token
        let userName = name
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(userName, forKey: "userName")
    }
}
