//
//  KeywordDefineVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/08.
//

import UIKit

class KeywordDefineVC: UIViewController {
    static let identifier = "KeywordDefineVC"
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var completeButton: UIButton!
    
    var keyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCompleteButton()
        setContentView()
        setTitleLabel()
        setNavigationBar()
        
    }
    
    func setKeyword(text: String){
        keyword = text
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        print("\(keyword.index(before: keyword.endIndex))")
        
        
        guard let lastText = keyword.last else{return}
        
        let unicodeValue = UnicodeScalar(String(lastText))?.value  // 유니코드 전환
        guard let keywordUnicode = unicodeValue else {return}
        
        if (keywordUnicode  < 0xAC00 || keywordUnicode > 0xD7A3) { return }   // 한글아니면 반환
        
        let last = (keywordUnicode - 0xAC00) % 28
        
        if last > 0 { // 받침이 있음
            titleLabel.text = "\(keyword)이란?\n나에게 무엇인가요?"
        }else{
            titleLabel.text = "\(keyword)란?\n나에게 무엇인가요?"
        }
        
    }
    
    func setCompleteButton(){
        completeButton.setTitle("저장할래요!", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    func setContentView(){
        contentView.layer.cornerRadius = 15
    }
    
    
    
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 정의"
      
        let leftButton: UIBarButtonItem = {
             let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissVC))
             return button
           }()
           navigationItem.leftBarButtonItem = leftButton
        
    }
    
    @objc func dismissVC() {
      self.navigationController?.popViewController(animated: true)
    }
    
}
