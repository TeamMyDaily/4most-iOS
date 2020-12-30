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
    
}

// MARK: - UITextFieldDelegate
extension EditKeywordVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        noticeLabel.text = ""
        if (string == " ") {
            noticeLabel.text = "잠깐! 공백은 입력할 수 없어요!"
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if updatedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count <= 6{
            addButton.isEnabled = true
            return true
        }
        else{
            noticeLabel.text = "최대 5글자의 단어만 입력 가능해요!"
            addButton.isEnabled = false
            return false
        }
    }
    
}
