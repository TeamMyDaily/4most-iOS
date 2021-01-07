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

        setupNavigationBar()
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
//
//    func checkButton(button: UIButton){
//        if button.currentImage == UIImage(named: "pencil.circle"){
//            button.setImage(UIImage(named: "pencil.circle.fill"), for: .normal)
//            checkCount += 1
//            print(checkCount)
//        }
//        else{
//            button.setImage(UIImage(named: "pencil.circle"), for: .normal)
//            checkCount -= 1
//            print(checkCount)
//        }
//
//        if checkCount == 2 {
//            nextButton.isEnabled = true
//        }
//    }
    
    //test용 -> 추후에 삭제할것!
    func checkButton(button: UIButton){
        checkCount += 1
        if checkCount >= 2{
            nextButton.isEnabled = true
        }
    }
}
