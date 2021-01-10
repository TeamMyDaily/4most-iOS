//
//  KeywordDefineVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/05.
//

import UIKit

class KeywordDecideVC: UIViewController {
    static let identifier = "KeywordDecideVC"
    
    @IBOutlet var keywordUIButtonList: [UIButton]!
    
    @IBOutlet var numberLabelList: [UILabel]!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var keywordCompleteButton: UIButton!
    
    @IBOutlet weak var skipButton: UIButton!
    
    var keywordList: [String] = []
    var keywordAndDefinition: [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        setCompleteButton()
        setSkipButton()
        setNavigationBar()
        setKeywordButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var i = 0
        var count = 0
        print("---------------")
        for txt in keywordList{
            if keywordAndDefinition[i][txt] != ""{
                keywordUIButtonList[i].setTitleColor(UIColor.mainBlack, for: .normal)
                numberLabelList[i].textColor = UIColor.mainLightOrange
                count += 1
            }
            
            for (key, value) in keywordAndDefinition[i]{
                
                print(" \(i) key = \(key), value = \(value)")
            }
            i += 1
        }
        
        if count > 0{
            skipButton.isHidden = true
            skipButton.isEnabled = false
            keywordCompleteButton.isHidden = true
            completeButton.isHidden = false
            completeButton.isEnabled = true
        }
        
    }
    
    @IBAction func skipDefiningKeyword(_ sender: UILabel) {
        alertKeyword()
        
    }
    
    @IBAction func touchUpCompletedKeyword(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToKeywordDefineView(_ sender: UIButton){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: KeywordDefineVC.identifier) as? KeywordDefineVC else {
            return
        }
        
        let selectedKeyword = sender.titleLabel?.text ?? ""
        
        for i in 0..<4{
            for (key, value) in keywordAndDefinition[i]{
                if key == selectedKeyword{
                    dvc.setKeywordAndDefinition(key: key, value: value)
                    break
                }
            }
        }
        
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
  
    func setReceivedKeywordList(list: [String]){
        keywordList = list
        for i in 0..<4{
            keywordAndDefinition.append([list[i] : ""])
        }
       
    }
    
    func setKeywordDefinition(key: String, value: String){

        for i in 0..<4{
            if keywordAndDefinition[i][key] != nil{
                keywordAndDefinition[i].updateValue(value, forKey: key)
            }
        }
        
    }
    
    func alertKeyword(){
        let txt = "MY > 나의 현재 키워드 > 키워드 정의에서 설정 할 수 있어요."
        let alert = UIAlertController(title: "키워드 정의를 건너뛰시겠어요?", message: txt, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel){ (action) in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: false, completion: nil)
    }
    
}

extension KeywordDecideVC{
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "회고 키워드에 대한\n나만의 정의를 작성해보세요!"
    }
    
    func setCompleteButton(){
        completeButton.titleLabel?.font =  UIFont.myBoldSystemFont(ofSize: 18)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
        completeButton.backgroundColor = UIColor.mainOrange
        completeButton.isHidden = true
        completeButton.setTitleColor(.white, for: .normal)
        
        keywordCompleteButton.titleLabel?.font = UIFont.myBoldSystemFont(ofSize: 18)
        keywordCompleteButton.layer.cornerRadius = 15
        keywordCompleteButton.isEnabled = false
        completeButton.backgroundColor = UIColor.mainOrange
        
    }
    
    func setSkipButton(){
        skipButton.layer.borderColor = UIColor.mainGray.cgColor
        skipButton.layer.borderWidth = 2
        skipButton.layer.cornerRadius = 15

    }
    
    func setKeywordButton(){
        for i in 0..<4{
            print("index = \(i)")
            keywordUIButtonList[i].setTitle(keywordList[i], for: .normal)
        }
        
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
