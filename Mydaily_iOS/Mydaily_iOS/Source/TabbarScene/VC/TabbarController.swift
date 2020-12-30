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
        guard let firstTab = DailyStoryboard.instantiateViewController(identifier: "DailyVC")
            as? DailyVC else {
            return
        }
        
        firstTab.tabBarItem.title = "하루의 기록"
//        firstTab.tabBarItem.image = UIImage(named: "gnbHome")?.withRenderingMode(.alwaysOriginal)
        firstTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        firstTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        //HomeView2
        let EvaluationStoryboard = UIStoryboard.init(name: "Evaluation", bundle: nil)
        guard let secondTab = EvaluationStoryboard.instantiateViewController(identifier: "EvaluationVC")
            as? EvaluationVC else {
            return
        }

        secondTab.tabBarItem.title = "평가 및 회고"
//        secondTab.tabBarItem.image = UIImage(named: "gnbBest")?.withRenderingMode(.alwaysOriginal)
        secondTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        secondTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        //DetailView
        let MypageStoryboard = UIStoryboard.init(name: "Mypage", bundle: nil)
        let thirdTab = MypageStoryboard.instantiateViewController(identifier: "MypageVC")
         
        thirdTab.tabBarItem.title = "My"
//        thirdTab.tabBarItem.image = UIImage(named: "gnbMypage")?.withRenderingMode(.alwaysOriginal)
        thirdTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemGray4], for: .normal)
        thirdTab.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        let tabs =  [firstTab, secondTab, thirdTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = firstTab
    }

}
