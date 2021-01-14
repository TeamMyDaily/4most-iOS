//
//  TabbarController.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    
    func setTabBar(){
        let DailyStoryboard = UIStoryboard.init(name: "Daily", bundle: nil)
        let firstTab = DailyStoryboard.instantiateViewController(identifier: "DailyNavi")

        
        firstTab.tabBarItem.title = "기록"
//        firstTab.tabBarItem.image = UIImage(named: "gnbHome")?.withRenderingMode(.alwaysOriginal)
        firstTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        firstTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        let GoalStoryboard = UIStoryboard.init(name: "Goal", bundle: nil)
        let goalTab = GoalStoryboard.instantiateViewController(identifier: "GoalNavi")

        
        goalTab.tabBarItem.title = "목표"
//        goalTab.tabBarItem.image = UIImage(named: "gnbHome")?.withRenderingMode(.alwaysOriginal)
        goalTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        goalTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        
        let EvaluationStoryboard = UIStoryboard.init(name: "Evaluation", bundle: nil)
        let secondTab = EvaluationStoryboard.instantiateViewController(identifier: "EvaluationNavi")

        secondTab.tabBarItem.title = "회고"
//        secondTab.tabBarItem.image = UIImage(named: "gnbBest")?.withRenderingMode(.alwaysOriginal)
        secondTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        secondTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        
        let MypageStoryboard = UIStoryboard.init(name: "Mypage", bundle: nil)
        let thirdTab = MypageStoryboard.instantiateViewController(identifier: "MypageNavigation")
         
        thirdTab.tabBarItem.title = "My"
//        thirdTab.tabBarItem.image = UIImage(named: "gnbMypage")?.withRenderingMode(.alwaysOriginal)
        thirdTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        thirdTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        let tabs =  [firstTab, goalTab, secondTab, thirdTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = firstTab
    }

}
