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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkButton1: UIButton!
    @IBOutlet weak var checkButton2: UIButton!
    var check1 = false
    var check2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackNavigationBar(titlelabel: "회원가입")
        setUI()
    }

    @IBAction func nextButton(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterVC else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func check1(_ sender: Any) {
        if check1 == false{
            check1 = true
            checkButton1.setImage(UIImage(named: "icCheckActive"), for: .normal)
        }else{
            check1 = false
            checkButton1.setImage(UIImage(named: "icCheckUnactive"), for: .normal)
        }
        if check1 && check2 {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .mainOrange
        }else{
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func check2(_ sender: Any) {
        if check2 == false{
            check2 = true
            checkButton2.setImage(UIImage(named: "icCheckActive"), for: .normal)
        }else{
            check2 = false
            checkButton2.setImage(UIImage(named: "icCheckUnactive"), for: .normal)
        }
        if check1 && check2 {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .mainOrange
        }else{
            nextButton.isEnabled = false
        }
    }
    
}

// MARK: - UI
extension RegisterEntryVC {
    func setUI() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = .mainGray
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .myMediumSystemFont(ofSize: 18)
        nextButton.layer.cornerRadius = 15
        label.text = "이상이 일상이 되는 회고, 포모스트"
        label.textColor = .mainBlack
        label.font = .myRegularSystemFont(ofSize: 12)
    }
    
//    private func setupNavigationBar() {
//        guard let navigationBar = self.navigationController?.navigationBar else { return }
//
//        navigationBar.isTranslucent = true
//        navigationBar.backgroundColor = UIColor.white
//        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationBar.shadowImage = UIImage()
//
//        self.navigationItem.title = "회원가입"
//
//        let leftButton: UIBarButtonItem = {
//            let button = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(dismissVC))
//            button.tintColor = .mainBlack
//            return button
//        }()
//        navigationItem.leftBarButtonItem = leftButton
//    }
    
//    @objc func dismissVC(){
//        self.navigationController?.popViewController(animated: true)
//    }
}
