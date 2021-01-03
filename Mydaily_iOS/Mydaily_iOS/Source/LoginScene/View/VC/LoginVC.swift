//
//  LoginVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/03.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeTextFields()
        setUI()
    }

    func setUI() {
        loginButton.isEnabled = false
        pwTextField.isSecureTextEntry = true
    }
}

// MARK: - TextField,Button
extension LoginVC {
    private func changeTextFields() {
        idTextField.addTarget(self, action: #selector(changeidTextfiledUI), for: .allEditingEvents)
        pwTextField.addTarget(self, action: #selector(changepwTextfiledUI), for: .allEditingEvents)
    }
    
    @objc
    func changeidTextfiledUI(){
        idTextField.backgroundColor = .white
        idTextField.layer.borderColor = UIColor.red.cgColor
        idTextField.layer.borderWidth = 1.5
        
        if (idTextField.text != "") && (pwTextField.text != ""){
            loginButton.isEnabled = true
        }
        else{
            loginButton.isEnabled = false
        }
    }
    
    @objc
    func changepwTextfiledUI(){
        pwTextField.backgroundColor = .white
        pwTextField.layer.borderColor = UIColor.red.cgColor
        pwTextField.layer.borderWidth = 1.5
        
        if (idTextField.text != "") && (pwTextField.text != ""){
            loginButton.isEnabled = true
        }
        else{
            loginButton.isEnabled = false
        }
    }
}
