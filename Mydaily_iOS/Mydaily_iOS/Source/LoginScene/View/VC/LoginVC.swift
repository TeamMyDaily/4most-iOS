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
    @IBOutlet weak var findIDButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var findPWButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(.clear, titlelabel: "")
        changeTextFields()
        setUI()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "RegisterEntryVC") as? RegisterEntryVC else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}

//MARK: - UI
extension LoginVC {
    func setUI() {
        loginButton.isEnabled = false
        pwTextField.isSecureTextEntry = true
        
        idTextField.layer.cornerRadius = 15
        idTextField.layer.borderColor = UIColor.mainGray.cgColor
        idTextField.layer.borderWidth = 1
        idTextField.setLeftPaddingPoints(15)
        
        pwTextField.layer.cornerRadius = 15
        pwTextField.layer.borderColor = UIColor.mainGray.cgColor
        pwTextField.layer.borderWidth = 1
        pwTextField.setLeftPaddingPoints(15)
        
        loginButton.layer.cornerRadius = 15
        loginButton.backgroundColor = .mainOrange
        loginButton.setTitle("포모스트 입장!", for: .normal)
        loginButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        loginButton.setTitleColor(.white, for: .normal)
        
        registerButton.setTitleColor(.mainGray, for: .normal)
        registerButton.titleLabel?.font = .myMediumSystemFont(ofSize: 12)
        findIDButton.setTitleColor(.mainGray, for: .normal)
        findIDButton.titleLabel?.font = .myMediumSystemFont(ofSize: 12)
        findPWButton.setTitleColor(.mainGray, for: .normal)
        findPWButton.titleLabel?.font = .myMediumSystemFont(ofSize: 12)
    }
    
//    func setupNavigationBar(_ color: UIColor) {
//        guard let navigationBar = self.navigationController?.navigationBar else { return }
//        
//        navigationBar.isTranslucent = true
//        navigationBar.backgroundColor = color
//        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationBar.shadowImage = UIImage()
//    }
}

// MARK: - TextField,Button
extension LoginVC {
    private func changeTextFields() {
        idTextField.addTarget(self, action: #selector(changeidTextfiledUI), for: .allEditingEvents)
        pwTextField.addTarget(self, action: #selector(changepwTextfiledUI), for: .allEditingEvents)
    }
    
    @objc
    func changeidTextfiledUI(){
        changeTextfiledUI(textfield: idTextField)
    }
    
    @objc
    func changepwTextfiledUI(){
        changeTextfiledUI(textfield: pwTextField)
    }
    
    func changeTextfiledUI(textfield: UITextField){
        if !(textfield.text!.isEmpty){
            textfield.backgroundColor = .white
            textfield.layer.borderColor = UIColor.mainOrange.cgColor
            textfield.layer.borderWidth = 1
        }
        else{
            textfield.layer.borderWidth = 1
            textfield.layer.borderColor = UIColor.mainGray.cgColor
        }
        
        if !(idTextField.text!.isEmpty) && !(pwTextField.text!.isEmpty){
            loginButton.isEnabled = true
        }
        else{
            loginButton.isEnabled = false
        }
    }
}
