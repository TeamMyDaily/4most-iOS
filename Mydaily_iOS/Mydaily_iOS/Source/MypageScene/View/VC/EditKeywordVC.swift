//
//  EditKeywordVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class EditKeywordVC: UIViewController {
    
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    
    var keywordArray:[String] = ["진정성","용기","대충"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordTextField.delegate = self
        addButton.isEnabled = false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func addButton(_ sender: Any) {
        if keywordArray.contains(keywordTextField.text ?? "") {
            addButton.isEnabled = false
            noticeLabel.text = "'\(keywordTextField.text ?? "")'은 이미 생성된 단어에요!"
        }
    }
}

// MARK: - UITextFieldDelegate
extension EditKeywordVC: UITextFieldDelegate{
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
