//
//  RegisterEntryVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/03.
//

import UIKit

class RegisterEntryVC: UIViewController {
    var checkCount = 0
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkPrivacyButton: UIButton!
    @IBOutlet weak var checkServiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(.clear, titlelabel: "회원가입")
        setUI()
    }

    @IBAction func checkPrivacyButton(_ sender: Any) {
        checkButton(button: checkPrivacyButton)
    }
    @IBAction func checkServiceButton(_ sender: Any) {
        checkButton(button: checkServiceButton)
    }
    @IBAction func nextButton(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterVC else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    
}

// MARK: - UI
extension RegisterEntryVC {
    func setUI() {
        nextButton.isEnabled = false
    }
    
    //test용 -> 추후에 삭제할것!
    func checkButton(button: UIButton){
        checkCount += 1
        if checkCount >= 2{
            nextButton.isEnabled = true
        }
    }
}
