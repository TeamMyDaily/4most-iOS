//
//  DailyWriteVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/06.
//

import UIKit

class DailyWriteVC: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var todayTitle: UITextField!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var textViewCount: UILabel!
    @IBOutlet weak var todayTextView: UITextView!
    @IBOutlet weak var scoreSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setUI()
        todayTitle.delegate = self
        placeholderSetting()
    }
}

extension DailyWriteVC {
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "기록"
        
        //        let leftButton: UIBarButtonItem = {
        //            let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
        //            return button
        //        }()
        
        let rightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(title: "저장", style: .done, target: self, action: nil)
            button.isEnabled = false
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.gray40], for: .disabled)
            
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.warmPink], for: .selected)
            
            return button
        }()
        
        //        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setUI(){
        textLabel.sizeToFit()
        textLabel.text = "아웃풋으로 채운\n하루에 대해 알려주세요"
        textLabel.numberOfLines = 2
        textLabel.font = .systemFont(ofSize: 24)
        //내가 적용하고싶은 폰트 사이즈
        let fontSize = UIFont.boldSystemFont(ofSize: 24)
        
        //label에 있는 Text를 NSMutableAttributedString으로 만들어준다.
        let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "")
        
        //위에서 만든 attributedStr에 addAttribute메소드를 통해 Attribute를 적용. kCTFontAttributeName은 value로 폰트크기와 폰트를 받을 수 있음.
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (textLabel.text! as NSString).range(of: "아웃풋"))
        
        //최종적으로 내 label에 속성을 적용
        textLabel.attributedText = attributedStr
        
        todayTitle.setLeftPaddingPoints(3)
        todayTitle.layer.addBorder([.bottom], color: .warmPink, width: 1, move: 5)
        todayTitle.font = .systemFont(ofSize: 16)
        todayTitle.placeholder = "오늘 하루 무슨일이 있었나요?"
        
        labelCount.font = .systemFont(ofSize: 12)
        labelCount.textColor = .warmPink
        
        todayTitle.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        todayTextView.backgroundColor = .gray30
        todayTextView.layer.cornerRadius = 15
        
        textViewCount.textColor = .warmPink

        
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        labelCount.text = "\(todayTitle.text?.count ?? 0)"
    }
    
}

extension DailyWriteVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if !updatedText.isEmpty {
            if updatedText.count <= 20{
                return true
            }
            else{
                return false
            }
        }
        else{
            return true
        }
    }
}

extension DailyWriteVC: UITextViewDelegate {
    func placeholderSetting() {
        todayTextView.delegate = self
        todayTextView.font = .systemFont(ofSize: 15)
        todayTextView.text = "조금 더 자세한 내용을 알려주세요!"
        todayTextView.textColor = UIColor.lightGray
        todayTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "조금 더 자세한 내용을 알려주세요!"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count -  range.length
        return newLength <= 500
    }
}
