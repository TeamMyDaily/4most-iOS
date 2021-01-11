//
//  RegisterVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/03.
//

import UIKit
import Moya

extension Notification.Name {
    static let registerVC = Notification.Name("registerVC")
}

class RegisterVC: UIViewController {
    
    private let authProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var userData: SignupModel?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkpwTextField: UITextField!
    @IBOutlet weak var validateEmailLabel: UILabel!
    @IBOutlet weak var validatePWLabel: UILabel!
    @IBOutlet weak var checkPWLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var validateNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    
    var checkValidate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(.clear, titlelabel: "회원가입")
        changeTextFields()
        setUI()
        nextButton.isEnabled = true
    }
    @IBAction func pwButton(_ sender: Any) {
        securityText(textfield: pwTextField)
    }
    @IBAction func checkpwButton(_ sender: Any) {
        securityText(textfield: checkpwTextField)
    }
    @IBAction func nextButton(_ sender: Any) {
        signup()
        let alert = UIAlertController(title: "가입을 축하합니다!", message: "4most회원이 되신걸 진심으로 축하합니다!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let viewControllers = self.navigationController?.viewControllers {
                if viewControllers.count > 2 {
                    self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                } else {
                            // fail
                }
            }
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

//MARK: - UI
extension RegisterVC {
    func setUI() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = .mainGray
        pwTextField.isSecureTextEntry = true
        checkpwTextField.isSecureTextEntry = true
        
        setInitUI(textfield: nameTextField)
        setInitUI(textfield: emailTextField)
        setInitUI(textfield: pwTextField)
        setInitUI(textfield: checkpwTextField)
        
        nameTextField.delegate = self
        nameLabel.text = "닉네임*"
        setLabelInitUI(label: nameLabel)
        emailLabel.text = "이메일*"
        setLabelInitUI(label: emailLabel)
        pwLabel.text = "비밀번호*"
        setLabelInitUI(label: pwLabel)
        pwCheckLabel.text = "비밀번호 확인*"
        setLabelInitUI(label: pwCheckLabel)

        validateNameLabel.font = .myRegularSystemFont(ofSize: 12)
        validateNameLabel.textColor = .mainPaleOrange
        validateEmailLabel.font = .myRegularSystemFont(ofSize: 12)
        validateEmailLabel.textColor = .mainPaleOrange
        validatePWLabel.font = .myRegularSystemFont(ofSize: 12)
        validatePWLabel.textColor = .mainPaleOrange
        checkPWLabel.font = .myRegularSystemFont(ofSize: 12)
        checkPWLabel.textColor = .mainPaleOrange
        
        nextButton.layer.cornerRadius = 15
        nextButton.backgroundColor = .mainGray
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
    }
}

// MARK: - TextField,Button
extension RegisterVC {
    private func changeTextFields() {
        nameTextField.addTarget(self, action: #selector(changeNameTextFieldUI), for: .allEditingEvents)
        emailTextField.addTarget(self, action: #selector(changeEmailTextfiledUI), for: .allEditingEvents)
        pwTextField.addTarget(self, action: #selector(changePWTextfiledUI), for: .allEditingEvents)
        checkpwTextField.addTarget(self, action: #selector(checkPWTextfiledUI), for: .allEditingEvents)
    }
    
    @objc
    func changeNameTextFieldUI(){
        changeTextfiledUI(textfield: nameTextField)
        
        checkValidateUI()
    }
    
    @objc
    func changeEmailTextfiledUI(){
        changeTextfiledUI(textfield: emailTextField)
        
        if !(emailTextField.text!.validateEmail()) {
            validateEmailLabel.text = "사용 불가능한 이메일이에요!"
            setLabelInitUI(label: emailLabel)
        }
        else{
            validateEmailLabel.text = ""
            emailLabel.textColor = .mainOrange
        }
        checkValidateUI()
    }
    
    @objc
    func changePWTextfiledUI(){
        changeTextfiledUI(textfield: pwTextField)
        
        if !(pwTextField.text!.validatePassword()) {
            validatePWLabel.text = "영어와 숫자 조합으로 6자리 이상 입력해 주세요!"
            setLabelInitUI(label: pwLabel)
        }
        else{
            if !(pwTextField.text == checkpwTextField.text) {
                checkPWLabel.text = "비밀번호가 서로 맞지 않아요!"
                setLabelInitUI(label: pwCheckLabel)
            }
            else{
                checkPWLabel.text = ""
                pwCheckLabel.textColor = .mainOrange
            }

            validatePWLabel.text = ""
            pwLabel.textColor = .mainOrange
        }
        checkValidateUI()
    }
    
    @objc
    func checkPWTextfiledUI(){
        changeTextfiledUI(textfield: checkpwTextField)
        
        if !(pwTextField.text == checkpwTextField.text) {
            checkPWLabel.text = "비밀번호가 서로 맞지 않아요!"
            setLabelInitUI(label: pwCheckLabel)
        }
        else{
            checkPWLabel.text = ""
            pwCheckLabel.textColor = .mainOrange
        }
        checkValidateUI()
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
    }
        
    func checkValidateUI(){
        if (pwTextField.text == checkpwTextField.text) && (emailTextField.text!.validateEmail()) && (pwTextField.text!.validatePassword()){
            checkValidate = true
        }
        else{
            checkValidate = false
        }
        
        if !(nameTextField.text!.isEmpty) && !(emailTextField.text!.isEmpty) && !(pwTextField.text!.isEmpty) && !(checkpwTextField.text!.isEmpty) && checkValidate{
            nextButton.isEnabled = true
            nextButton.backgroundColor = .mainOrange
        }
        else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = .mainGray
        }
    }
    
    func securityText(textfield: UITextField){
        if textfield.isSecureTextEntry == true {
            textfield.isSecureTextEntry = false
        }
        else{
            textfield.isSecureTextEntry = true
        }
    }
    func setInitUI(textfield: UITextField){
        textfield.layer.cornerRadius = 15
        textfield.layer.borderColor = UIColor.mainGray.cgColor
        textfield.layer.borderWidth = 1
        textfield.setLeftPaddingPoints(15)
    }
    func setLabelInitUI(label: UILabel){
        label.backgroundColor = .white
        label.font = .myRegularSystemFont(ofSize: 14)
        label.textColor = .mainBlack
        label.textAlignment = .center
        
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainOrange, range: ((label.text ?? "") as NSString).range(of:"*"))
        label.attributedText = attributedString
    }
}

//MARK: - String
extension String {
    // E-mail address validation
//    public func validateEmail() -> Bool {
//        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
//        
//        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return predicate.evaluate(with: self)
//    }
    
    // Password validation
    public func validatePassword() -> Bool {
        let passwordRegEx = "^(?=.*[0-9])(?=.*[a-z]).{6,100}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: self)
    }
}

extension RegisterVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateNameLabel.text = ""
        setLabelInitUI(label: nameLabel)
        if (string == " ") {
            validateNameLabel.text = "공백은 입력할 수 없어요!"
            setLabelInitUI(label: nameLabel)
            return false
        }
        if textField.isFirstResponder {
            let validString = CharacterSet(charactersIn: "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢abcdefghijklmnopqrstuvwxyzQWERTYUIOPASDFGHJKLZXCVBNM")
            if string.rangeOfCharacter(from: validString) != nil {
                validateNameLabel.text = "영어/특수문자는 입력할 수 없어요!"
                setLabelInitUI(label: nameLabel)
                return false
            }
        }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if !updatedText.isEmpty {
            if updatedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count <= 7{
                if !(nameTextField.text!.isEmpty) && !(emailTextField.text!.isEmpty) && !(pwTextField.text!.isEmpty) && !(checkpwTextField.text!.isEmpty) && checkValidate {
                    nextButton.isEnabled = true
                    nameLabel.textColor = .mainOrange
                }
                self.nextButton.isEnabled = true
                nameLabel.textColor = .mainOrange
                return true
            }
            else{
                validateNameLabel.text = "최대 6글자의 단어만 입력 가능해요!"
                nextButton.isEnabled = false
                setLabelInitUI(label: nameLabel)
                return false
            }
        }
        else{
            setLabelInitUI(label: nameLabel)
            nextButton.isEnabled = false
            return true
        }
    }
}

extension RegisterVC {
    func signup(){
        let param = SignupRequest.init(self.emailTextField.text!, self.pwTextField.text!, self.checkpwTextField.text!, self.nameTextField.text!)
        print(param)
        authProvider.request(.signUp(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        self.userData = try result.map(SignupModel.self)
                        NotificationCenter.default.post(name: .registerVC, object: nil, userInfo: ["username": self.emailTextField.text ?? "", "userpw": self.pwTextField.text ?? ""])
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
