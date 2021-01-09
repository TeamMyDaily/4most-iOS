//
//  MypageChangePasswordVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/09.
//

import UIKit

class MypageChangePasswordVC: UIViewController {
    @IBOutlet weak var currentPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var notVerifiyLabel: UILabel!
    @IBOutlet weak var passwordTopInfoLabel: UILabel!
    @IBOutlet weak var passwordBottomInfoLabel: UILabel!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var currentPasswordCheckButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var labelStackView: UIStackView!
    
    var isConfirm = false
    var isNewConfirm = false
    let passwd = "12345df"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setButton()
        setTextField()
        setKeyboard()
    }
    
    @IBAction func touchUpConfirmText(_ sender: Any) {
        if currentPasswordTextField.text == passwd {
            showConfirmAlert()
            isConfirm = true
        } else {
            showRetryAlert()
            isConfirm = false
        }
    }
    
    @IBAction func touchUpShowNewText(_ sender: Any) {
        if newPasswordTextField.isSecureTextEntry == true {
            newPasswordTextField.isSecureTextEntry = false
        } else {
            newPasswordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func touchUpShowConfirmText(_ sender: Any) {
        if confirmNewPasswordTextField.isSecureTextEntry == false {
            confirmNewPasswordTextField.isSecureTextEntry = true
        } else {
            confirmNewPasswordTextField.isSecureTextEntry = false
        }
    }
    
    @IBAction func touchUpChange(_ sender: Any) {
        showChangeAlert()
    }
}

extension MypageChangePasswordVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != newPasswordTextField.text {
            UIView.animate(withDuration: 0.1) {
                self.labelStackView.transform = CGAffineTransform(translationX: 0, y: 10)
            }
            isNewConfirm = false
        } else {
            UIView.animate(withDuration: 0.1) {
                self.labelStackView.transform = CGAffineTransform(translationX: 0, y: -10)
            }
            isNewConfirm = true
            checkButton()
        }
    }
}

extension MypageChangePasswordVC {
    private func setLabel() {
        currentPasswordLabel.text = "현재 비밀번호를 입력해주세요."
        currentPasswordLabel.textColor = .mainBlack
        currentPasswordLabel.font = .myRegularSystemFont(ofSize: 16)
        
        newPasswordLabel.text = "새로운 비밀번호를 입력해주세요."
        newPasswordLabel.textColor = .mainBlack
        newPasswordLabel.font = .myRegularSystemFont(ofSize: 16)
        
        passwordTopInfoLabel.text = "비밀번호는 6자리 이상 영어, 숫자를 조합하여 설정해주세요."
        passwordTopInfoLabel.textColor = .mainGray
        passwordTopInfoLabel.font = .myRegularSystemFont(ofSize: 12)
        
        passwordBottomInfoLabel.text = "안전한 계정 사용을 위해 비밀번호는 주기적으로 변경해주세요."
        passwordBottomInfoLabel.textColor = .mainGray
        passwordBottomInfoLabel.font = .myRegularSystemFont(ofSize: 12)
        
        notVerifiyLabel.text = "비밀번호가 서로 맞지 않아요!"
        notVerifiyLabel.textColor = .mainOrange
        notVerifiyLabel.font = .myRegularSystemFont(ofSize: 12)
        notVerifiyLabel.isHidden = true
    }
    
    private func setTextField() {
        currentPasswordTextField.placeholder = "비밀번호 입력"
        currentPasswordTextField.borderStyle = .none
        
        newPasswordTextField.addTarget(self, action: #selector(changePWTextfiledUI), for: .allEditingEvents)
        newPasswordTextField.placeholder = "비밀번호(6자리 이상)"
        newPasswordTextField.borderStyle = .none
        
        confirmNewPasswordTextField.addTarget(self, action: #selector(checkPWTextfiledUI), for: .allEditingEvents)
        confirmNewPasswordTextField.delegate = self
        confirmNewPasswordTextField.placeholder = "비밀번호 확인"
        confirmNewPasswordTextField.borderStyle = .none
        
        let currentBorder = CALayer()
        let newBorder = CALayer()
        let confirmBorder = CALayer()
        
        currentBorder.frame = CGRect(x: 0, y: currentPasswordTextField.frame.size.height-3, width: currentPasswordTextField.frame.width, height: 1)
        currentBorder.backgroundColor = UIColor.mainGray.cgColor
        currentPasswordTextField.layer.addSublayer((currentBorder))
        currentPasswordTextField.isSecureTextEntry = true
        currentPasswordTextField.setLeftPaddingPoints(10)

        newBorder.frame = CGRect(x: 0, y: newPasswordTextField.frame.size.height-3, width: newPasswordTextField.frame.width, height: 1)
        newBorder.backgroundColor = UIColor.mainGray.cgColor
        newPasswordTextField.layer.addSublayer((newBorder))
        newPasswordTextField.isSecureTextEntry = false
        newPasswordTextField.setLeftPaddingPoints(10)
        newPasswordTextField.setRightPaddingPoints(40)
        
        confirmBorder.frame = CGRect(x: 0, y: confirmNewPasswordTextField.frame.size.height-3, width: confirmNewPasswordTextField.frame.width, height: 1)
        confirmBorder.backgroundColor = UIColor.mainGray.cgColor
        confirmNewPasswordTextField.layer.addSublayer((confirmBorder))
        confirmNewPasswordTextField.isSecureTextEntry = true
        confirmNewPasswordTextField.setLeftPaddingPoints(10)
        confirmNewPasswordTextField.setRightPaddingPoints(40)
    }
    
    private func setButton() {
        currentPasswordCheckButton.setTitle("확인", for: .normal)
        currentPasswordCheckButton.setTitleColor(.white, for: .normal)
        currentPasswordCheckButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        currentPasswordCheckButton.backgroundColor = .mainOrange
        currentPasswordCheckButton.layer.cornerRadius = 8
        currentPasswordCheckButton.layer.masksToBounds = true
        
        changeButton.setTitle("바꿀래요", for: .normal)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        changeButton.backgroundColor = .mainGray
        changeButton.isEnabled = false
        changeButton.layer.cornerRadius = 15
        changeButton.layer.masksToBounds = true
    }
    
    private func checkButton() {
        if isNewConfirm && isConfirm {
            changeButton.backgroundColor = .mainOrange
            changeButton.isEnabled = true
        } else {
            changeButton.backgroundColor = .mainGray
            changeButton.isEnabled = false
        }
    }
    
    private func showConfirmAlert() {
        let alert = UIAlertController(title: "계정 확인 되었습니다.", message: "비밀번호가 맞아요!\n비밀번호를 변경하시겠어요?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "다음", style: .default) { (action) in
            self.newPasswordTextField.becomeFirstResponder()
        }
        okAction.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func showRetryAlert() {
        let alert = UIAlertController(title: "비밀번호를 다시 입력해주세요.", message: "현재 비밀번호와 맞지 않아요.\n비밀번호를 다시 입력해주세요.", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "다음에하기", style: .default)
        let okAction = UIAlertAction(title: "재입력하기", style: .default) { (action) in
            self.currentPasswordTextField.text = ""
        }
        noAction.setValue(UIColor.mainGray, forKey: "titleTextColor")
        okAction.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        alert.addAction(noAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func showChangeAlert() {
        let alert = UIAlertController(title: "비밀번호가 변경되었습니다.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.currentPasswordTextField.text = ""
            self.newPasswordTextField.text = ""
            self.confirmNewPasswordTextField.text = ""
            
            self.changeButton.isEnabled = false
            self.changeButton.backgroundColor = .mainGray
        }
        okAction.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissGestureKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissGestureKeyboard() {
        view.endEditing(true)
    }
    
    @objc func changePWTextfiledUI(){
        if !(newPasswordTextField.text!.validatePassword()) {
            notVerifiyLabel.text = "영어와 숫자 조합으로 6자리 이상 입력해 주세요!"
            notVerifiyLabel.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.labelStackView.transform = CGAffineTransform(translationX: 0, y: 10)
            }
        }
        else{
            if !(newPasswordTextField.text == confirmNewPasswordTextField.text) {
                notVerifiyLabel.text = "비밀번호가 서로 맞지 않아요!"
                notVerifiyLabel.isHidden = false
                isNewConfirm = false
            }
            else{
                notVerifiyLabel.isHidden = true
                UIView.animate(withDuration: 0.1) {
                    self.labelStackView.transform = CGAffineTransform(translationX: 0, y: -10)
                }
                isNewConfirm = true
                checkButton()
            }
        }
    }
    
    @objc func checkPWTextfiledUI(){
        if !(newPasswordTextField.text == confirmNewPasswordTextField.text) {
            notVerifiyLabel.text = "비밀번호가 서로 맞지 않아요!"
            notVerifiyLabel.isHidden = false
        }
        else{
            notVerifiyLabel.text = ""
            notVerifiyLabel.isHidden = true
        }
    }
}
