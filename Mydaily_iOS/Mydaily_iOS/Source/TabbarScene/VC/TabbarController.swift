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
        let myTabbar = self.tabBarController?.tabBar
        myTabbar?.tintColor = .mainOrange
        
        
        let DailyStoryboard = UIStoryboard.init(name: "Daily", bundle: nil)
        let firstTab = DailyStoryboard.instantiateViewController(identifier: "DailyNavi")

        
//        firstTab.tabBarItem.title = "기/록"
//        firstTab.tabBarItem.image = UIImage(named: "nav_record_unselected")?.withRenderingMode(.automatic)
        firstTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"nav_record_unselected"), selectedImage: UIImage(named: "nav_record_selected"))
        
        
        
        let GoalStoryboard = UIStoryboard.init(name: "Goal", bundle: nil)
        let goalTab = GoalStoryboard.instantiateViewController(identifier: "GoalNavi")

        
//        goalTab.tabBarItem.title = "목표"
//        goalTab.tabBarItem.image = UIImage(named: "nav_goal_unselected")?.withRenderingMode(.alwaysOriginal)
        goalTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"nav_goal_unselected"), selectedImage: UIImage(named: "nav_goal_selected"))
        let EvaluationStoryboard = UIStoryboard.init(name: "Evaluation", bundle: nil)
        let secondTab = EvaluationStoryboard.instantiateViewController(identifier: "EvaluationNavi")

//        secondTab.tabBarItem.title = "회고"
//        secondTab.tabBarItem.image = UIImage(named: "nav_remembrance_unselected")?.withRenderingMode(.alwaysOriginal)
        secondTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"nav_remembrance_unselected"), selectedImage: UIImage(named: "nav_remembrance_selected"))
        secondTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.mainGray], for: .normal)
        secondTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.mainOrange], for: .selected)
        
        
        let MypageStoryboard = UIStoryboard.init(name: "Mypage", bundle: nil)
        let thirdTab = MypageStoryboard.instantiateViewController(identifier: "MypageNavigation")
         
//        thirdTab.tabBarItem.title = "My"
//        thirdTab.tabBarItem.image = UIImage(named: "nav_my_unselected")?.withRenderingMode(.alwaysOriginal)
        thirdTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"nav_my_unselected"), selectedImage: UIImage(named: "nav_my_selected"))
        thirdTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.mainGray], for: .normal)
        thirdTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.mainOrange], for: .selected)
        
        let tabs =  [firstTab, goalTab, secondTab, thirdTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = firstTab
    }

}
