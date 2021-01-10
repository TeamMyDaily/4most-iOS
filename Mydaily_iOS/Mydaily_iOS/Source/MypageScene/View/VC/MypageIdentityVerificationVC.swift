//
//  MypageIdentityVerificationVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/08.
//

import UIKit

class MypageIdentityVerificationVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var infomationLabel: UILabel!
    @IBOutlet weak var verificationLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
}

//MARK: UI
extension MypageIdentityVerificationVC {
    private func setLabel() {
        titleLabel.font = .myRegularSystemFont(ofSize: 12)
        titleLabel.text = "본인인증 정보"
        titleLabel.textColor = .mainGray
        
        nameLabel.font = .myRegularSystemFont(ofSize: 18)
        nameLabel.text = "엄석준"
        nameLabel.textColor = .mainBlack
        
        emailLabel.font = .myRegularSystemFont(ofSize: 15)
        emailLabel.text = "tlsdbsdk05250@gmail.com"
        emailLabel.textColor = .mainOrange
        
        infomationLabel.font = .myRegularSystemFont(ofSize: 12)
        infomationLabel.text = "본인인증 정보는 가입시 기입한 이메일을 통해 진행되며 본인확인이 필요한 서비스에서 이용됩니다."
        infomationLabel.textColor = .mainGray
        
        verificationLabel.font = .myRegularSystemFont(ofSize: 12)
        verificationLabel.text = "2020.12.26 인증됨"
        verificationLabel.textColor = .mainBlack
        
        guideLabel.font = .myRegularSystemFont(ofSize: 12)
        guideLabel.text = "본인인증 정보는 사용자 확인을 위한 목적으로만 활용되며 타인 정보로 변경 할 수 없습니다."
        guideLabel.textColor = .mainBlack
    }
}
