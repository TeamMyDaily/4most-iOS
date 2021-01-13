//
//  AddUserKeywordVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 and 장혜령 on 2021/01/04.

import UIKit
import Moya

class AddUserKeywordVC: UIViewController {
    
    private let authProvider = MoyaProvider<KeywordServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var responseToken: AddKeywordModel?
    var responseStatus = -1
    var semaphore = DispatchSemaphore(value: 1)
    
    static let identifier = "AddUserKeywordVC"
    
    @IBOutlet weak var keywordTextField: UITextField!
    
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var guideLabel: UILabel!
    let originButtonColor: UIColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
   
    var keywordArray:[String] = []
    var userKeyword = ""
    
    var isFirst = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setContent()
        keywordTextField.delegate = self
        addButton.isEnabled = false
        
    }
    
    
    func setKeywordArray(list: [String]){
        keywordArray = list
    }
    
    @IBAction func addUserKeyword(_ sender: UIButton) {
        userKeyword = keywordTextField.text ?? ""
        
        if userKeyword.count > 5{
            addButton.isEnabled = false
            noticeLabel.text = "최대 5글자의 단어만 입력 가능해요!"
            addButton.backgroundColor = UIColor.mainGray
            
        } else if keywordArray.contains(userKeyword) {
            addButton.isEnabled = false
            noticeLabel.text = "'\(userKeyword)'은 이미 생성된 단어에요!"
            addButton.backgroundColor = UIColor.mainGray
        }else{
            
            if userKeyword != ""{
                if isFirst{ // 처음 키워드 설정
                    let endIndex = self.navigationController?.viewControllers.count ?? 2
                    guard let pvc = self.navigationController?.viewControllers[endIndex-2] as? KeywordSettingVC  else {
                       return
                    }
                    pvc.addUserKeyword(text: userKeyword)
                    pvc.checkForUserKeyword(check: true)
                    self.navigationController?.popViewController(animated: true)
                
                }else{ // 마이페이지에서 왔을 때
                    addUserKeywordInServer()
                    let endIndex = self.navigationController?.viewControllers.count ?? 2
                    guard let pvc = self.navigationController?.viewControllers[endIndex-2] as? KeywordSettingVC  else {
                       return
                    }
                   
                }
               
            }
            
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddUserKeywordVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        noticeLabel.text = ""
        if (string == " ") {
            noticeLabel.text = "잠깐! 공백은 입력할 수 없어요!"
            return false
        }
        
        if textField.isFirstResponder {
            let validString = CharacterSet(charactersIn: "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢")
            if string.rangeOfCharacter(from: validString) != nil {
                noticeLabel.text = "잠깐! 특수문자는 입력할 수 없어요!"
                return false
            }
            
            let englishString = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
            if string.rangeOfCharacter(from: englishString) != nil{
                noticeLabel.text = "잠깐! 영어는 입력할 수 없어요!"
                return false
            }
            
            let numberString = CharacterSet(charactersIn: "1234567890")
            if string.rangeOfCharacter(from: numberString) != nil{
                noticeLabel.text = "잠깐! 숫자는 입력할 수 없어요!"
                return false
            }
            
            if keywordArray.contains(string){
                noticeLabel.text = "잠깐! 이미 있슴"
                return false
            }
            
        }
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 5{
            noticeLabel.text = "!!!!최대 5글자의 단어만 입력 가능해요!"
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor.mainGray
        }
        
        if !updatedText.isEmpty {
            if updatedText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count <= 6{
                addButton.isEnabled = true
                
                addButton.backgroundColor = UIColor.mainOrange
                return true
            }
            else {
                noticeLabel.text = "최대 5글자의 단어만 입력 가능해요!"
                addButton.isEnabled = false
                addButton.backgroundColor = UIColor.mainGray
                return false
            }
        }
        else{
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor.mainGray
            return true
        }
    }
}


// MARK: - UI
extension AddUserKeywordVC{
  
    func setContent(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "찾으시는 가치(단어)가\n없으신가요?"
        
        guideLabel.numberOfLines = 0
        guideLabel.text = "공백 없이 최대 5글자까지 가능해요.\n명사 형태를 추천해요."
        
        addButton.layer.cornerRadius = 15
    }
   
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
      
        self.navigationItem.title = "키워드 추가"
        
        let leftButton: UIBarButtonItem = {
             let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissVC))
             return button
           }()
           navigationItem.leftBarButtonItem = leftButton
    }

    @objc func dismissVC() {
      self.navigationController?.popViewController(animated: true)
    }
    
}



// MARK: - Network
extension AddUserKeywordVC {
    
    func addUserKeywordInServer(){
       
        let param = AddKeywordRequest(keyword: userKeyword)
         authProvider.request(.addKeyword(param: param)){ responds in
             switch responds {
             case .success(let result):
                 do {
                     self.responseStatus = result.statusCode
                     self.responseToken = try result.map(AddKeywordModel.self)
                     self.navigationController?.popViewController(animated: true)
                 } catch(let err){
                    self.noticeLabel.text = "이미 존재하는 키워드입니다."
                    self.addButton.isEnabled = false
                    self.addButton.backgroundColor = UIColor.mainGray
                     print(err.localizedDescription)
                 }
             case .failure(let err):
                 print(err.localizedDescription)
             }
         }
    }
}

