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
    @IBOutlet weak var skipButton: UIButton!
    
    var keywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        setCompleteButton()
        setSkipButton()
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
    
    func setSkipButton(){
        skipButton.layer.borderColor = UIColor.gray.cgColor
        skipButton.layer.borderWidth = 2
        skipButton.layer.cornerRadius = 15

    }
    
    @IBAction func skipDefiningKeyword(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
        let leftButton: UIBarButtonItem = {
             let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissVC))
             return button
           }()
           navigationItem.leftBarButtonItem = leftButton
        
        let questionItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle.fill"), style: .plain, target: self, action: #selector(goKeywordPopUp))
        navigationItem.rightBarButtonItem = questionItem
    }

    @objc func dismissVC() {
      self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goKeywordPopUp(){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "KeywordPopUpVC") else {
            return
        }
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }
    
}
