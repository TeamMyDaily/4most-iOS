//
//  AddUserKeywordVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/04.

import UIKit

class AddUserKeywordVC: UIViewController {
    
    static let identifier = "AddUserKeywordVC"
    
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var addButton: UITextField!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var guideLabel: UILabel!
    
    var keywordArray:[String] = ["진정성","용기","대충"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabel()
        setGuideLabel()
        keywordTextField.delegate = self
        addButton.isEnabled = false
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "찾으시는 가치(단어)가\n없으신가요?"
        
    }
    
    func setGuideLabel(){
        guideLabel.numberOfLines = 0
        guideLabel.text = "공백 없이 최대 5글자까지 가능해요.\n 명사 형태를 추천해요."
    }
    
    @IBAction func submitKeyword(_ sender: UIButton) {
        if keywordArray.contains(keywordTextField.text ?? "") {
            addButton.isEnabled = false
            noticeLabel.text = "'\(keywordTextField.text ?? "")'은 이미 생성된 단어에요!"
        }else{
         
            guard let pvc = self.navigationController?.presentingViewController as? KeywordSettingVC else {
               return
            }
           
            let userKeyword = keywordTextField.text ?? ""
            
            if userKeyword != ""{
                pvc.addUserKeyword(text: userKeyword)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
}

// MARK: - UITextFieldDelegate
extension AddUserKeywordVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        noticeLabel.text = ""
        if (string == " ") {
            noticeLabel.text = "잠깐! 공백은 입력할 수 없어요!"
            return false
        }
        if textField.isFirstResponder {
            let validString = CharacterSet(charactersIn: "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢")
            if string.rangeOfCharacter(from: validString) != nil {
                noticeLabel.text = "잠깐! 특수문자는 입력할 수 없어요!"
                return false
            }
        }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if !updatedText.isEmpty {
            if updatedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count <= 6{
                addButton.isEnabled = true
                self.addButton.isEnabled = true
                addButton.backgroundColor = .orange
                return true
            }
            else{
                noticeLabel.text = "최대 5글자의 단어만 입력 가능해요!"
                addButton.isEnabled = false
                return false
            }
        }
        else{
            addButton.isEnabled = false
            return true
        }
    }
}
