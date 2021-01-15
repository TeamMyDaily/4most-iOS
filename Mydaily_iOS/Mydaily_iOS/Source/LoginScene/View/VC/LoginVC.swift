//
//  LoginVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/03.
//

import UIKit
import Moya

class LoginVC: UIViewController {

    private let authProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var token: SigninModel?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var findIDButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var findPWButton: UIButton!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var logoImg: UIImageView!
    var autoLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(.clear, titlelabel: "")
        changeTextFields()
        setUI()
    }
    
    @IBAction func autoLoginButton(_ sender: Any) {
        //자동로그인
        if autoLogin == false{
            autoLogin = true
            autoLoginButton.setImage(UIImage(named: "icCheckActive"), for: .normal)
            autoLoginLabel.textColor = .mainOrange
        }
        else{
            autoLogin = false
            autoLoginButton.setImage(UIImage(named: "icCheckUnactive"), for: .normal)
            autoLoginLabel.textColor = .mainGray
        }
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "RegisterEntryVC") as? RegisterEntryVC else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        signin()
    }
}

//MARK: - UI
extension LoginVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }

    func setUI() {
        idTextField.delegate = self
        pwTextField.delegate = self
        
        autoLoginLabel.font = .myRegularSystemFont(ofSize: 12)
        autoLoginLabel.textColor = .mainGray
        
        loginButton.isEnabled = false
        pwTextField.isSecureTextEntry = true
        
        idTextField.layer.cornerRadius = 15
        idTextField.layer.borderColor = UIColor.mainGray.cgColor
        idTextField.layer.borderWidth = 1
        idTextField.placeholder = "이메일"
        idTextField.setLeftPaddingPoints(15)
        
        pwTextField.layer.cornerRadius = 15
        pwTextField.layer.borderColor = UIColor.mainGray.cgColor
        pwTextField.layer.borderWidth = 1
        pwTextField.placeholder = "비밀번호"
        pwTextField.setLeftPaddingPoints(15)
        
        loginButton.layer.cornerRadius = 15
        loginButton.backgroundColor = .mainGray
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        loginButton.setTitleColor(.white, for: .normal)
        
        registerButton.setTitleColor(.mainGray, for: .normal)
        registerButton.titleLabel?.font = .myMediumSystemFont(ofSize: 12)
        findIDButton.setTitleColor(.mainGray, for: .normal)
        findIDButton.titleLabel?.font = .myMediumSystemFont(ofSize: 12)
        findPWButton.setTitleColor(.mainGray, for: .normal)
        findPWButton.titleLabel?.font = .myMediumSystemFont(ofSize: 12)
        
        addObserver()
    }
    
//    func setupNavigationBar(_ color: UIColor) {
//        guard let navigationBar = self.navigationController?.navigationBar else { return }
//        
//        navigationBar.isTranslucent = true
//        navigationBar.backgroundColor = color
//        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationBar.shadowImage = UIImage()
//    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: .registerVC, object: nil)
    }
    
    @objc
    func reloadUI(_ notification: NSNotification) {
        guard let userEmail = notification.userInfo?["username"] as? String else { return }
        guard let userPW = notification.userInfo?["userpw"] as? String else { return }
        
        idTextField.text = userEmail
        pwTextField.text = userPW
        
        loginButton.isEnabled = true
        loginButton.backgroundColor = .mainOrange
    }
    func downanimation(){
            UIView.animate(withDuration: 0.3, animations: {
                self.autoLoginButton.frame.origin.y += 80
                self.autoLoginLabel.frame.origin.y += 80
                self.pwTextField.frame.origin.y += 80
                self.idTextField.frame.origin.y += 80
                self.stackView.frame.origin.y += 80
                self.loginButton.frame.origin.y += 80
                self.logoImg.frame.origin.y += 80
            })
        }
    
    func animation(){
        UIView.animate(withDuration: 0.1) {
            self.autoLoginButton.frame.origin.y -= 80
            self.autoLoginLabel.frame.origin.y -= 80
            self.pwTextField.frame.origin.y -= 80
            self.idTextField.frame.origin.y -= 80
            self.stackView.frame.origin.y -= 80
            self.loginButton.frame.origin.y -= 80
            self.logoImg.frame.origin.y -= 80
        }
    }
    
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
            loginButton.backgroundColor = .mainOrange
        }
        else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = .mainGray
        }
    }
    
}

extension LoginVC {
    func signin(){
        let param = SigninRequest.init(self.idTextField.text!, self.pwTextField.text!)
        authProvider.request(.signIn(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        self.token = try result.map(SigninModel.self)
                        UserDefaults.standard.setValue(self.token?.data.accessToken, forKey: "accessToken")
                        if self.token?.status == 400{
                            if self.token?.message == "존재하지 않는 이메일 입니다."{
                                
                            }else{
                                
                            }
                        }
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
//                    self.token = try err.map(SigninModel.self)
//                    print("@\(self.token)")
                    print(err.localizedDescription)
            }
        }
    }
}

extension LoginVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == idTextField {
            animation()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == pwTextField {
            downanimation()
        }
    }
    
  //리턴키
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
