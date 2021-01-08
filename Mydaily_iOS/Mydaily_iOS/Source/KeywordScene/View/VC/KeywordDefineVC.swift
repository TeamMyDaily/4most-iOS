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
    @IBOutlet var textView: UIView!
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var completeButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet var changedNumberLabel: UILabel!
    
    var contentViewSize = 0
    var keyword = "키워드"
    var keywordOrder = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        contentTextField.delegate = self
        setKeyboardNotification()
        contentViewSize = Int(contentView.frame.height)
        print(contentViewSize)
    }

    
    func setKeyword(text: String){
        keyword = text
    }
    
    func setContent(){
        setTitleLabel()
        setCompleteButton()
        setContentView()
        setNavigationBar()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentTextField.resignFirstResponder()
    }
    
    @IBAction func touchUpSaveKeywordDefinition(_ sender: UIButton){
        let endIndex = self.navigationController?.viewControllers.count ?? 0
        
        guard let pvc = self.navigationController?.viewControllers[endIndex] as? KeywordDecideVC else {
           return
        }
        
        let definition = contentTextField.text ?? ""
        pvc.setKeywordDefinition(key: keyword, value: definition)
        self.navigationController?.popViewController(animated: true)
    }

}

extension KeywordDefineVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        changedNumberLabel.text = "\(updatedText.count)"
        changedNumberLabel.tintColor = UIColor.mainOrange
        
        if updatedText.count <= 0 ||  updatedText.count >= 20 {
            changedNumberLabel.textColor = UIColor.mainGray
            numberLabel.textColor = UIColor.mainOrange
            completeButton.isEnabled = false
            completeButton.backgroundColor = UIColor.mainGray
            return false
        }else{
            changedNumberLabel.textColor = UIColor.mainOrange
            completeButton.isEnabled = true
            completeButton.backgroundColor = UIColor.mainOrange
            numberLabel.textColor = UIColor.mainGray
        }
        
        if updatedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count < 6{
//            addButton.isEnabled = true
//            self.addButton.isEnabled = true
//            addButton.backgroundColor = .orange
            return true
        }
       
        return true
    }
    
}

extension KeywordDefineVC{

    func setKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter){
    
        contentView.frame.size.height = 100
       // completeButton.constraint(completeButton.heightAnchor, constant: 300)
        contentView.updateConstraints()
        print( contentView.frame.size.height)
        
    }
 
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        //contentView.sizeThatFits(CGSize(from: 200))
        contentView.frame.size.height = CGFloat(contentViewSize)
        completeButton.frame.origin.y -= 50
        print( contentView.frame.size.height)
    }
    
}


//UI관련 사항 setting
extension KeywordDefineVC{
    
    func setCompleteButton(){
        completeButton.setTitle("저장할래요!", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    func setContentView(){
        textView.layer.cornerRadius = 15
        textView.backgroundColor = UIColor.mainLightGray
        contentTextField.borderStyle = UITextField.BorderStyle.none
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        print("\(keyword.index(before: keyword.endIndex))")
        
        if checkLastText(text: keyword) {
            titleLabel.text = "\(keyword)이란?\n나에게 무엇인가요?"
        }else{
            titleLabel.text = "\(keyword)란?\n나에게 무엇인가요?"
        }

    }
    
    
    //받침이 있으면 true, 없으면 false
    func checkLastText(text: String) -> Bool{
        
        guard let lastText = text.last else{return false}
        let unicodeValue = UnicodeScalar(String(lastText))?.value  // 유니코드 전환
        guard let keywordUnicode = unicodeValue else {return false}
        
        if (keywordUnicode  < 0xAC00 || keywordUnicode > 0xD7A3) { return false}   // 한글아니면 반환
       
        let last = (keywordUnicode - 0xAC00) % 28
        
        if last > 0 { // 받침이 있음
            return true
        }else{
           return false
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

