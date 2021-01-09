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
        setKeyboardGesture()
    }
    
    @IBAction func touchUpWithdrawal(_ sender: Any) {
        if passwordTextField.text == pw {
            print("비밀번호 확인, 탈퇴 완료")
        } else {
            print("비밀번호 틀림")
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

//MARK: UI
extension MypageWithdrawalVC {
    private func setLabel() {
        titleLabel.font = .myBlackSystemFont(ofSize: 21)
        titleLabel.text = "포모스트를 떠날래요."
        titleLabel.textColor = .mainBlack
        
        withdrawalInfoLabel.font = .myRegularSystemFont(ofSize: 16)
        withdrawalInfoLabel.text = "회원정보 확인 후 탈퇴가 완료됩니다."
        withdrawalInfoLabel.textColor = .mainBlack
        
        emailTitleLabel.font = .myRegularSystemFont(ofSize: 16)
        emailTitleLabel.text = "이메일"
        emailTitleLabel.textColor = .mainBlack
        
        emailLabel.font = .myRegularSystemFont(ofSize: 16)
        emailLabel.text = "tlsdbsdk05250@gmail.com"
        emailLabel.textColor = .mainOrange
        
        passwordTitleLabel.font = .myRegularSystemFont(ofSize: 16)
        passwordTitleLabel.text = "비밀번호"
        passwordTitleLabel.textColor = .mainBlack
        
        topInfoLabel.font = .myMediumSystemFont(ofSize: 12)
        topInfoLabel.text = "지금 회원 탈퇴를 하시면 포모스트를 더이상 이용하실 수 없습니다."
        topInfoLabel.textColor = .mainBlack
        
        middleInfoLabel.font = .myMediumSystemFont(ofSize: 12)
        middleInfoLabel.text = "또한 포모스트를 가입/사용 하면서 축적된 정보와 기록은 모두 삭제되며, 복구가 불가능 합니다."
        middleInfoLabel.textColor = .mainGray
        
        bottomInfoLabel.font = .myMediumSystemFont(ofSize: 12)
        bottomInfoLabel.text = "해당 아이디로 작성한 기록과 회고등은 영구 소멸되므로, 미리 확인하시고 탈퇴를 진행하시기를 바랍니다."
        bottomInfoLabel.textColor = .mainGray
    }
    
    private func setTextfield() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height-1, width: passwordTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.mainGray.cgColor
        passwordTextField.layer.addSublayer((border))
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.placeholder = "비밀번호 입력"
        passwordTextField.borderStyle = .none
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setButton() {
        withdrawalButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        withdrawalButton.setTitle("떠날래요", for: .normal)
        withdrawalButton.setTitleColor(.white, for: .normal)
        withdrawalButton.backgroundColor = .mainGray
        withdrawalButton.layer.cornerRadius = 15
        withdrawalButton.layer.masksToBounds = true
        withdrawalButton.isEnabled = false
    }
}

//MARK: keyboard
extension MypageWithdrawalVC {
    private func setKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissGestureKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissGestureKeyboard() {
        view.endEditing(true)
    }
}
