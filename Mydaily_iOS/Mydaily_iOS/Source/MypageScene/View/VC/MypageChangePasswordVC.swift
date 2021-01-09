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
    @IBOutlet weak var showNewButton: UIButton!
    @IBOutlet weak var showConfirmButton: UIButton!
    @IBOutlet weak var labelStackView: UIStackView!
    
    var isCurrentPasswordRight = false
    var isNewPasswordRight = false
    var isSameWithNewPassword = false
    
    let passwd = "12345df"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setTextField()
        setTextFieldAddTarget()
        setButton()
        setKeyboard()
    }
    
    @IBAction func touchUpConfirmCurrentPassword(_ sender: Any) {
        if currentPasswordTextField.text == passwd {
            showConfirmAlert()
            isCurrentPasswordRight = true
        } else {
            showRetryAlert()
            isCurrentPasswordRight = false
        }
    }
    
    @IBAction func touchUpShowNewPassword(_ sender: Any) {
        if newPasswordTextField.isSecureTextEntry == true {
            newPasswordTextField.isSecureTextEntry = false
        } else {
            newPasswordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func touchUpShowConfirmPassword(_ sender: Any) {
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showConfirmButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            showConfirmButton.isHidden = true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != newPasswordTextField.text {
            isNewPasswordRight = false
            stackViewPositionDown()
            checkButton()
        } else {
            isNewPasswordRight = true
            stackViewPositionUp()
            checkButton()
        }
    }
}

//MARK: UI
extension MypageChangePasswordVC {
    private func setLabel() {
        currentPasswordLabel.font = .myRegularSystemFont(ofSize: 16)
        currentPasswordLabel.text = "현재 비밀번호를 입력해주세요."
        currentPasswordLabel.textColor = .mainBlack
        
        newPasswordLabel.font = .myRegularSystemFont(ofSize: 16)
        newPasswordLabel.text = "새로운 비밀번호를 입력해주세요."
        newPasswordLabel.textColor = .mainBlack
        
        passwordTopInfoLabel.font = .myRegularSystemFont(ofSize: 12)
        passwordTopInfoLabel.text = "비밀번호는 6자리 이상 영어, 숫자를 조합하여 설정해주세요."
        passwordTopInfoLabel.textColor = .mainGray
        
        passwordBottomInfoLabel.font = .myRegularSystemFont(ofSize: 12)
        passwordBottomInfoLabel.text = "안전한 계정 사용을 위해 비밀번호는 주기적으로 변경해주세요."
        passwordBottomInfoLabel.textColor = .mainGray
        
        notVerifiyLabel.font = .myRegularSystemFont(ofSize: 12)
        notVerifiyLabel.text = "비밀번호가 서로 맞지 않아요!"
        notVerifiyLabel.textColor = .mainOrange
        notVerifiyLabel.isHidden = true
    }
    
    private func setTextField() {
        let currentPasswordBorder = CALayer()
        currentPasswordBorder.frame = CGRect(x: 0, y: currentPasswordTextField.frame.size.height-3, width: currentPasswordTextField.frame.width, height: 1)
        currentPasswordBorder.backgroundColor = UIColor.mainGray.cgColor
        currentPasswordTextField.layer.addSublayer((currentPasswordBorder))
        currentPasswordTextField.placeholder = "비밀번호 입력"
        currentPasswordTextField.borderStyle = .none
        currentPasswordTextField.setLeftPaddingPoints(10)
        currentPasswordTextField.isSecureTextEntry = true
        
        let newPasswordBorder = CALayer()
        newPasswordBorder.frame = CGRect(x: 0, y: newPasswordTextField.frame.size.height-3, width: newPasswordTextField.frame.width, height: 1)
        newPasswordBorder.backgroundColor = UIColor.mainGray.cgColor
        newPasswordTextField.layer.addSublayer((newPasswordBorder))
        newPasswordTextField.placeholder = "비밀번호(6자리 이상)"
        newPasswordTextField.borderStyle = .none
        newPasswordTextField.setLeftPaddingPoints(10)
        newPasswordTextField.setRightPaddingPoints(40)
        newPasswordTextField.isSecureTextEntry = false
        
        let confirmPasswordBorder = CALayer()
        confirmPasswordBorder.frame = CGRect(x: 0, y: confirmNewPasswordTextField.frame.size.height-3, width: confirmNewPasswordTextField.frame.width, height: 1)
        confirmPasswordBorder.backgroundColor = UIColor.mainGray.cgColor
        confirmNewPasswordTextField.layer.addSublayer((confirmPasswordBorder))
        confirmNewPasswordTextField.placeholder = "비밀번호 확인"
        confirmNewPasswordTextField.borderStyle = .none
        confirmNewPasswordTextField.setLeftPaddingPoints(10)
        confirmNewPasswordTextField.setRightPaddingPoints(40)
        confirmNewPasswordTextField.delegate = self
        confirmNewPasswordTextField.isSecureTextEntry = true
    }
    
    private func setButton() {
        currentPasswordCheckButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        currentPasswordCheckButton.setTitle("확인", for: .normal)
        currentPasswordCheckButton.setTitleColor(.white, for: .normal)
        currentPasswordCheckButton.backgroundColor = .mainOrange
        currentPasswordCheckButton.layer.cornerRadius = 8
        currentPasswordCheckButton.layer.masksToBounds = true
        
        changeButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        changeButton.setTitle("바꿀래요", for: .normal)
        changeButton.setTitleColor(.white, for: .normal)
        changeButton.backgroundColor = .mainGray
        changeButton.layer.cornerRadius = 15
        changeButton.isEnabled = false
        changeButton.layer.masksToBounds = true
        
        showNewButton.isHidden = true
        showConfirmButton.isHidden = true
    }
}

//MARK: Animation
extension MypageChangePasswordVC {
    private func stackViewPositionDown() {
        UIView.animate(withDuration: 0.1) {
            self.labelStackView.transform = CGAffineTransform(translationX: 0, y: 10)
        }
    }
    
    private func stackViewPositionUp() {
        UIView.animate(withDuration: 0.1) {
            self.labelStackView.transform = CGAffineTransform(translationX: 0, y: -10)
        }
    }
}

//MARK: Button
extension MypageChangePasswordVC {
    private func checkButton() {
        if isNewPasswordRight && isCurrentPasswordRight && isSameWithNewPassword {
            changeButton.backgroundColor = .mainOrange
            changeButton.isEnabled = true
        } else {
            changeButton.backgroundColor = .mainGray
            changeButton.isEnabled = false
        }
    }
}

//MARK: Alert
extension MypageChangePasswordVC {
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
            
            self.changeButton.backgroundColor = .mainGray
            self.changeButton.isEnabled = false
        }
        okAction.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

//MARK: Keyboard
extension MypageChangePasswordVC {
    private func setKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissGestureKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissGestureKeyboard() {
        view.endEditing(true)
    }
}

//MARK: TextField
extension MypageChangePasswordVC {
    private func setTextFieldAddTarget() {
        newPasswordTextField.addTarget(self, action: #selector(checkNewPasswordTextField), for: .allEditingEvents)
        confirmNewPasswordTextField.addTarget(self, action: #selector(checkConfirmNewPasswordTextField), for: .allEditingEvents)
    }
    
    @objc func checkNewPasswordTextField(){
        showNewButton.isHidden = false
        
        if !(newPasswordTextField.text!.validatePassword()) {
            stackViewPositionDown()
            notVerifiyLabel.text = "영어와 숫자 조합으로 6자리 이상 입력해 주세요!"
            notVerifiyLabel.isHidden = false
            isSameWithNewPassword = false
            checkButton()
        } else {
            isSameWithNewPassword = true
            if !(newPasswordTextField.text == confirmNewPasswordTextField.text) {
                stackViewPositionDown()
                notVerifiyLabel.text = "비밀번호가 서로 맞지 않아요!"
                notVerifiyLabel.isHidden = false
                isNewPasswordRight = false
                checkButton()
            }
            else{
                stackViewPositionUp()
                notVerifiyLabel.isHidden = true
                isNewPasswordRight = true
                checkButton()
            }
        }
        
        if newPasswordTextField.text == "" {
            showNewButton.isHidden = true
            if confirmNewPasswordTextField.text == "" {
                notVerifiyLabel.isHidden = true
                stackViewPositionUp()
            }
        }
    }
    
    @objc func checkConfirmNewPasswordTextField(){
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
