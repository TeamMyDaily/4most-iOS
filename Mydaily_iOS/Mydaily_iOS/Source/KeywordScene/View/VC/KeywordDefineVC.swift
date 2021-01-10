//
//  KeywordDefineVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/08.
//

import UIKit

class KeywordDefineVC: UIViewController{
    static let identifier = "KeywordDefineVC"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        contentTextView.delegate = self
        setKeyboardNotification()
        contentViewSize = Int(contentView.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setContent()
        contentTextView.delegate = self
        setKeyboardNotification()
    }

    
    func setKeywordAndDefinition(key: String, value: String){
        keyword = key
        definition = value
    }
    
    func setContent(){
        setTitleLabel()
        setCompleteButton()
        setContentView()
        setNavigationBar()
        setModifiedMode()
    }
    
    func setDefinition(text: String){
        definition = text
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentTextView.resignFirstResponder()
    }
    
    @IBAction func touchUpSaveKeywordDefinition(_ sender: UIButton){
        
        if checkSaving{
            checkSaving = false
        }else{
            checkSaving = true
        }
        
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
            print("checkSaving = \(checkSaving)")
            dismissVC()
        }
        
        
//        if definition != "" { // 수정모드로 들어온 것
//
//            if checkSaving == false{ // 저장해야되는 상태에서 눌림
//                checkSaving = true
//                completeButton.isHidden = true
//                textView.backgroundColor = UIColor.white
//                textView.borderWidth = 2
//                textView.borderColor = UIColor.mainOrange
//                contentTextView.isEditable = false
//                contentTextView.backgroundColor = .white
//
//
//            }else{
//                checkSaving = false
//                textView.backgroundColor = UIColor.mainLightGray
//                textView.borderWidth = 0
//                completeButton.isHidden = false
//                contentTextView.isEditable = true
//            }
//
//
//        }else{
//            if checkSaving{
//                print("처음 들어왔음 \(checkSaving)")
//                dismissVC()
//                checkSaving = false
//            }else{
//                checkSaving = true
//                dismissVC()
//                print("처음 들어왔음 \(checkSaving)")
//            }
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
        
        return newLength <= 20
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textLength = textView.text.count
        changedNumberLabel.text = "\(textView.text.count)"
        
        if textLength <= 0 || textLength >= 20 {
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
       // completeButton.constraint(completeButton.heightAnchor, constant: 300)
        contentView.updateConstraints()
        print( contentView.frame.size.height)
        
    }
 
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        //contentView.sizeThatFits(CGSize(from: 200))
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
        
//        if contentTextView.text.isEmpty {
//            contentTextView.text = "나만의 정의를 작성해 주세요."
//            contentTextView.textColor = UIColor.lightGray
//        }
        
        
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        subTitleLabel.textColor = UIColor.mainOrange
        print("\(keyword.index(before: keyword.endIndex))")
        
        if modifiedMode{
            titleLabel.text = "\(keyword)에 대한\n나만의 정의에요!"
            subTitleLabel.text = "정의를 바꾸고 싶다면, 수정 하실 수 있어요!"
        }else{
            if checkLastText(text: keyword) {
                titleLabel.text = "\(keyword)이란?\n나에게 무엇인가요?"
            }else{
                titleLabel.text = "\(keyword)란?\n나에게 무엇인가요?"
            }
        }
        
        
    }
    
    func setModifiedMode(){
        if definition != ""{
            modifiedMode = true
            print("-----수정 모드-----")
        }else{
            print("-----수정모드 아님-----")
            modifiedMode = false
        }
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
             let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissVC))
             return button
           }()
           navigationItem.leftBarButtonItem = leftButton
        
        if modifiedMode{
            let rightButton : UIBarButtonItem = {
                let button = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(modifyDefinition))
                return button
            }()
            
            navigationItem.rightBarButtonItem = rightButton
            
        }
        
    }
    
    @objc func dismissVC() {
        if contentTextView.text.count <= 0{
            self.navigationController?.popViewController(animated: true)
        }else{
            
            if checkSaving == true{ // 저장된 상태
                
                let endIndex = self.navigationController?.viewControllers.count ?? 0
                guard let pvc = self.navigationController?.viewControllers[endIndex-2] as? KeywordDecideVC else {
                   return
                }
        
                let definition = contentTextView.text ?? ""
                pvc.setKeywordDefinition(key: keyword, value: definition)
                print("넘기기 전 key = \(keyword), value = \(definition)")
                self.navigationController?.popViewController(animated: true)
                
            }else{
                setSavingAlert()
            }
        }
    }
    
    func setSavingAlert(){
        var txt = ""
        if modifiedMode{
            txt = "작성 완료를 하지 않아 작성하신 내용이 저장되지 않습니다."
        }else{
            txt = "수정사항 저장 안할꺼야?"
        }
        
        
        let alert = UIAlertController(title: "작성을 종료하시겠습니까?", message: txt, preferredStyle: UIAlertController.Style.alert)
        
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
            sender.tintColor = .blue
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

