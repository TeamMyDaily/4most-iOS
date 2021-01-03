//
//  RegisterVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/03.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkpwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
}

//MARK: - UI
extension RegisterVC {
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "회원가입"
        
//        let leftButton: UIBarButtonItem = {
//            let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
//            return button
//        }()
//
//        navigationItem.leftBarButtonItem = leftButton
//    }
//
//    @objc
//    func dismissVC() {
//        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextField,Button
//extension RegisterVC {
//    private func changeTextFields() {
//        nameTextField.addTarget(self, action: #selector(changenameTextFieldUI), for: .allEditingEvents)
//        pwTextField.addTarget(self, action: #selector(changepwTextfiledUI), for: .allEditingEvents)
//    }
//    
//    @objc
//    func changenameTextFieldUI(){
//        nameTextField.backgroundColor = .white
//        nameTextField.layer.borderColor = UIColor.red.cgColor
//        nameTextField.layer.borderWidth = 1.5
//        
//        
//    }
//    
//    @objc
//    func changepwTextfiledUI(){
//        pwTextField.backgroundColor = .white
//        pwTextField.layer.borderColor = UIColor.red.cgColor
//        pwTextField.layer.borderWidth = 1.5
//        
//        if nameTextField.text?.isEmpty
//            loginButton.isEnabled = true
//        }
//        else{
//            loginButton.isEnabled = false
//        }
//    }
//}
