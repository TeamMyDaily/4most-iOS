//
//  KeywordDefineVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/08.
//

import UIKit
import Moya

class KeywordDefineVC: UIViewController{
    static let identifier = "KeywordDefineVC"
    
    private let authProvider = MoyaProvider<KeywordServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var textView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet var completeButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet var changedNumberLabel: UILabel!
    
    var contentViewSize = 0
    var keyword = "키워드"
    var keywordOrder = -1
    var checkSaving = false
    
    var modifiedMode = false
    var definition = ""
    var totalKeywordId = -1
    var isFirt = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        contentTextView.delegate = self
        setKeyboardNotification()
        contentViewSize = Int(contentView.frame.height)
    }
    
    func setKeywordAndDefinition(key: String, value: String){
        keyword = key
        definition = value
        print("키워드 정의로 넘겨온 \(keyword), \(definition)")
        
    }
    
    func setContent(){
        setModifiedMode()
        setTitleLabel()
        setCompleteButton()
        setContentView()
        setNavigationBar()
    }
    
    func setDefinition(text: String){
        definition = text
    }
    
    func setTotalKeywordId(keywordId: Int){
        totalKeywordId = keywordId
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentTextView.resignFirstResponder()
    }
    
    @IBAction func touchUpSaveKeywordDefinition(_ sender: UIButton){
        print("modify = \(modifiedMode)")
        if checkSaving{
            checkSaving = false
        }else{
            checkSaving = true
        }
        
        definition = contentTextView.text
        postKeywordDefinition()
        
        if modifiedMode{ //수정모드에서 저장하기 버튼 눌림
            completeButton.isHidden = true
            textView.backgroundColor = UIColor.white
            textView.borderWidth = 1
            textView.borderColor = UIColor.mainOrange
            contentTextView.isEditable = false
            contentTextView.backgroundColor = .white
            changedNumberLabel.isHidden = true
            numberLabel.isHidden = true
            navigationItem.rightBarButtonItem?.title = "수정"
            
        }else{
            dismissVC()
        }
        
    }
    
    func setNavigationModifyButton(modifyMode: Bool){
       // saving == true : 수정 버튼 활성화, 저장버튼 비활성화
        if modifyMode == true {
            navigationItem.rightBarButtonItem?.title = "수정"
        }else{
            navigationItem.rightBarButtonItem?.title = ""
            
        }
    }

}


extension KeywordDefineVC: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 200
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textLength = textView.text.count
        changedNumberLabel.text = "\(textView.text.count)"
        
        if textLength <= 0 || textLength >= 200 {
            changedNumberLabel.textColor = UIColor.mainGray
            numberLabel.textColor = UIColor.mainOrange
            completeButton.isEnabled = false
            if textLength == 0{
                numberLabel.textColor = UIColor.mainGray
            }
            completeButton.backgroundColor = UIColor.mainGray
            
        }else{
            changedNumberLabel.textColor = UIColor.mainOrange
            completeButton.isEnabled = true
            completeButton.backgroundColor = UIColor.mainOrange
            numberLabel.textColor = UIColor.mainGray
        }
    
        
    }
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
}


//UI keyboard
extension KeywordDefineVC{

    func setKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter){
    
        contentView.frame.size.height = 100
        contentView.updateConstraints()
        print( contentView.frame.size.height)
        
    }
 
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        
        contentView.frame.size.height = CGFloat(contentViewSize)
        completeButton.frame.origin.y -= 50
        print( contentView.frame.size.height)
    }
    
}

//UI관련 사항 setting
extension KeywordDefineVC{
    
    func setCompleteButton(){
        
        if modifiedMode{
            completeButton.setTitle("저장할래요", for: .normal)
        }else{
            completeButton.setTitle("작성완료", for: .normal)
        }
       
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    func setContentView(){
        textView.layer.cornerRadius = 15
        textView.backgroundColor = UIColor.mainLightGray
        contentTextView.backgroundColor = UIColor.mainLightGray
        changedNumberLabel.textColor = .mainGray
        
        contentTextView.text = definition
        changedNumberLabel.text = "\(definition.count)"
        
        print("definition = \(definition)")
        
        if modifiedMode{
            completeButton.isHidden = true
            textView.backgroundColor = UIColor.white
            textView.borderWidth = 1
            textView.borderColor = UIColor.mainOrange
            contentTextView.isEditable = false
            contentTextView.backgroundColor = .white
            changedNumberLabel.isHidden = true
            numberLabel.isHidden = true
            
        }else{
            contentTextView.text = "나만의 정의를 작성해 주세요."
            contentTextView.textColor = UIColor.lightGray
        }
        
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        subTitleLabel.textColor = UIColor.mainOrange
        print("\(keyword.index(before: keyword.endIndex))")
        
        if modifiedMode{
            titleLabel.text = "\(keyword)에 대한\n나만의 정의에요!"
            subTitleLabel.text = "내가 추구하는 가치의 의미에요!"
        }else{
            if checkLastText(text: keyword) {
                titleLabel.text = "\(keyword)이란?\n나에게 무엇인가요?"
            }else{
                titleLabel.text = "\(keyword)란?\n나에게 무엇인가요?"
            }
        }
        
    }
    
    func setModifiedMode(){
        modifiedMode = definition != "" ? true : false
        print("modify mode = \(modifiedMode)")
    }
    
    
    //받침이 있으면 true, 없으면 false
    func checkLastText(text: String) -> Bool{
        
        guard let lastText = text.last else{return false}
        let unicodeValue = UnicodeScalar(String(lastText))?.value  // 유니코드 전환
        guard let keywordUnicode = unicodeValue else {return false}
        
        if (keywordUnicode  < 0xAC00 || keywordUnicode > 0xD7A3) { return false}   // 한글아니면 반환
       
        let last = (keywordUnicode - 0xAC00) % 28
        
        if last > 0 { // 받침이 있음
            return true
        }else{
           return false
        }
        
    }
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 정의"
      
        let leftButton: UIBarButtonItem = {
             let button = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(dismissVC))
            button.tintColor = UIColor.mainBlack
             return button
           }()
           navigationItem.leftBarButtonItem = leftButton
        
        if modifiedMode{
            let rightButton : UIBarButtonItem = {
                let button = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(modifyDefinition))
                button.tintColor = UIColor.mainBlue
                return button
            }()
            
            navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    @objc func dismissVC() {
        print("modify mode = \(modifiedMode)")
        print("checkSaving = \(checkSaving)")
        
        if contentTextView.text == "나만의 정의를 작성해 주세요." || contentTextView.text.count <= 0{
            self.navigationController?.popViewController(animated: true)
        }else{
            
            if checkSaving == true{ // 저장된 상태
                if isFirt{
                    let endIndex = self.navigationController?.viewControllers.count ?? 0
                    guard let pvc = self.navigationController?.viewControllers[endIndex-2] as? KeywordDecideVC else {
                        print()
                       return
                    }
                        
                    let definition = contentTextView.text ?? ""
                    pvc.setKeywordDefinition(key: keyword, value: definition)
                    isFirt = false
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                setSavingAlert()
            }
            
            if modifiedMode{
                checkSaving = completeButton.isHidden
            }
//            }else{
//                self.navigationController?.popViewController(animated: true)
//            }
        }
    }
    
    func setSavingAlert(){
        var txt = ""
        if modifiedMode{
            txt = "뒤로가기를 누르면 수정사항이 삭제되고\n이전페이지로 돌아갑니다."
        }else{
            txt = "작성 완료를 하지 않아 작성하신 내용이 저장되지 않습니다."
        }
        
        let alert = UIAlertController(title: "정말 뒤로 가시겠어요?", message: txt, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel){ (action) in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    
    @objc func modifyDefinition(_ sender: UIBarButtonItem){
      
        if sender.title == "수정"{
            sender.tintColor = UIColor.mainBlue
            checkSaving = false
            textView.backgroundColor = UIColor.mainLightGray
            textView.borderWidth = 0
            completeButton.isHidden = false
            numberLabel.isHidden = false
            changedNumberLabel.isHidden = false
            contentTextView.isEditable = true
            contentTextView.backgroundColor = textView.backgroundColor
            sender.title = ""
        }
    }
   
}

extension KeywordDefineVC{
    func postKeywordDefinition(){
        let param = KeywordDefinitionRequest(name: keyword, definition: definition)
        authProvider.request(.keywordDefinition(param: param)){ responds in
            switch responds{
            case .success(let result):
                do{
                    let responseToken = try result.map(BasicResponseModel.self)
                    if responseToken.status == 200{
                        if self.modifiedMode != true{
                            self.dismissVC()
                        }
                    }
                    print(responseToken.message)
                    print("-----------------------")
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
