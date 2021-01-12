//
//  GoalWriteVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/07.
//

import UIKit

class GoalWriteVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewCount: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setUI()
        placeholderSetting()
        
    }
    @IBAction func saveButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GoalWriteVC {
    func setUI(){
        textLabel.text = "아웃풋에\n가까워 지기 위한 목표"
        textLabel.numberOfLines = 2
        textLabel.font = .myMediumSystemFont(ofSize: 25)
        textLabel.textColor = .mainBlack
        textLabel.sizeToFit()
        
        let fontSize = UIFont.myBlackSystemFont(ofSize: 25)
        let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (textLabel.text! as NSString).range(of: "아웃풋"))
        textLabel.attributedText = attributedStr
        
        textView.backgroundColor = .gray30
        textView.layer.cornerRadius = 15
        
        textViewCount.textColor = .mainOrange
        
        saveButton.isEnabled = false
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .mainGray
        saveButton.setTitle("작성완료", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "목표"
        
                let leftButton: UIBarButtonItem = {
                    let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(cancelAlertaction))
                    return button
                }()
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    private func cancelAlertaction() {
        
        let alert = UIAlertController(
            title: "주의!",
            message: "작성중인 글을 취소하시겠습니까?\n취소할 시, 작성된 글은 저장되지 않습니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        let cancel = UIAlertAction(title: "작성취소", style: .destructive) {
            _ in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let okAction = UIAlertAction(title: "닫기", style: .default)
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension GoalWriteVC: UITextViewDelegate{
    func placeholderSetting() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 15)
        textView.text = "조금 더 자세한 내용을 알려주세요!"
        textView.textColor = UIColor.lightGray
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.mainBlack
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
        return newLength <= 25
    }

    func textViewDidChange(_ textView: UITextView) {
        textViewCount.text = "\(textView.text.count)"
        if textView.text.count == 0 {
            saveButton.isEnabled = false
            saveButton.layer.cornerRadius = 15
            saveButton.backgroundColor = .mainGray
            saveButton.setTitle("작성완료", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        }
        else{
            saveButton.isEnabled = true
            saveButton.layer.cornerRadius = 15
            saveButton.backgroundColor = .mainOrange
            saveButton.setTitle("작성완료", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
        }
    }
}
