//
//  KeywordDefineVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/05.
//

import UIKit

class KeywordDefineVC: UIViewController {
    static let identifier = "KeywordDefineVC"
    
    @IBOutlet var keywordUILabelList: [UILabel]!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var keywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        setCompleteButton()
        setKeywordLabelList()
        setNavigationBar()
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "회고 키워드에 대한\n나만의 정의를 작성해보세요!"
    }
    
    func setCompleteButton(){
        completeButton.titleLabel?.font =  UIFont(name: "System-Bold", size: 18.0)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    func setKeywordLabelList(){
        for i in 0..<4{
            keywordUILabelList[i].text = keywordList[i]
        }
    }
    
    func setReceivedKeywordList(list: [String]){
        keywordList = list
    }
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 정의"
    }
    
}
