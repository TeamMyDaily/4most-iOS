//
//  MypageWithdrawalVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/08.
//

import UIKit

class MypageWithdrawalVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var withdrawalInfoLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var topInfoLabel: UILabel!
    @IBOutlet weak var middleInfoLabel: UILabel!
    @IBOutlet weak var bottomInfoLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var withdrawalButton: UIButton!
    
    let pw = "123456"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setTextfield()
        setButton()
        setKeyboard()
    }
    
    @IBAction func touchUpWithdrawal(_ sender: Any) {
        if passwordTextField.text == pw {
            print("good bye")
        } else {
            print("no")
        }
    }
}

extension MypageWithdrawalVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            withdrawalButton.isEnabled = true
            withdrawalButton.backgroundColor = .mainOrange
        } else {
            withdrawalButton.isEnabled = false
            withdrawalButton.backgroundColor = .mainGray
        }
    }
}

extension MypageWithdrawalVC {
    private func setLabel() {
        titleLabel.text = "포모스트를 떠날래요."
        titleLabel.font = .myBlackSystemFont(ofSize: 21)
        titleLabel.textColor = .mainBlack
        
        withdrawalInfoLabel.text = "회원정보 확인 후 탈퇴가 완료됩니다."
        withdrawalInfoLabel.font = .myRegularSystemFont(ofSize: 16)
        withdrawalInfoLabel.textColor = .mainBlack
        
        emailTitleLabel.text = "이메일"
        emailTitleLabel.font = .myRegularSystemFont(ofSize: 16)
        emailTitleLabel.textColor = .mainBlack
        
        emailLabel.text = "tlsdbsdk05250@gmail.com"
        emailLabel.font = .myRegularSystemFont(ofSize: 16)
        emailLabel.textColor = .mainOrange
        
        passwordTitleLabel.text = "비밀번호"
        passwordTitleLabel.font = .myRegularSystemFont(ofSize: 16)
        passwordTitleLabel.textColor = .mainBlack
        
        topInfoLabel.text = "지금 회원 탈퇴를 하시면 포모스트를 더이상 이용하실 수 없습니다."
        topInfoLabel.font = .myMediumSystemFont(ofSize: 12)
        topInfoLabel.textColor = .mainBlack
        
        middleInfoLabel.text = "또한 포모스트를 가입/사용 하면서 축적된 정보와 기록은 모두 삭제되며, 복구가 불가능 합니다."
        middleInfoLabel.font = .myMediumSystemFont(ofSize: 12)
        middleInfoLabel.textColor = .mainGray
        
        bottomInfoLabel.text = "해당 아이디로 작성한 기록과 회고등은 영구 소멸되므로, 미리 확인하시고 탈퇴를 진행하시기를 바랍니다."
        bottomInfoLabel.font = .myMediumSystemFont(ofSize: 12)
        bottomInfoLabel.textColor = .mainGray
    }
    
    private func setTextfield() {
        passwordTextField.delegate = self
        passwordTextField.placeholder = "비밀번호 입력"
        passwordTextField.borderStyle = .none
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height-1, width: passwordTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.mainGray.cgColor
        passwordTextField.layer.addSublayer((border))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setLeftPaddingPoints(10)
    }
    
    private func setButton() {
        withdrawalButton.setTitle("떠날래요", for: .normal)
        withdrawalButton.setTitleColor(.white, for: .normal)
        withdrawalButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        withdrawalButton.backgroundColor = .mainGray
        withdrawalButton.layer.cornerRadius = 15
        withdrawalButton.layer.masksToBounds = true
        withdrawalButton.isEnabled = false
    }
    
    private func setKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissGestureKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissGestureKeyboard() {
        view.endEditing(true)
    }
}
