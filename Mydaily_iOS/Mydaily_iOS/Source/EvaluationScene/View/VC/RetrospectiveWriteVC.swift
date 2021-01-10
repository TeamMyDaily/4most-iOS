//
//  RetrospectiveWriteVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/05.
//

import UIKit

class RetrospectiveWriteVC: UIViewController {
    static let identifier = "RetrospectiveWriteVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var limitCountLabel: UILabel!
    @IBOutlet weak var countNumberLabel: UILabel!
    @IBOutlet weak var writeView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var writeTextView: UITextView = {
        let writeTextView = UITextView()
        writeTextView.translatesAutoresizingMaskIntoConstraints = false
        return writeTextView
    }()
    
    var saveContent: ((String, Int) -> ())?
    var textViewHeightConstraint: NSLayoutConstraint?
    
    var contentSaver = ""
    var counter = 0
    var cellNum = 0
    
    var cellPlaceholders = ["이번주, 어떤 내 모습을 칭찬 해주고 싶나요?", "한 주에 아쉬움이 남은 점이 있을까요?", "다음주에는 어떻게 지내고 싶은가요?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        setLabel()
        setView()
        setTextView()
        setButton()
        setData()
        setKeyboard()
    }
}

//MARK: Action
extension RetrospectiveWriteVC {
    @IBAction func touchUpSave(_ sender: Any) {
        guard let text: String = writeTextView.text else {return}
        saveContent?(text, counter)
        
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UI
extension RetrospectiveWriteVC {
    private func setTabBar() {
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setLabel() {
        titleLabel.font = .myBoldSystemFont(ofSize: 20)
        titleLabel.text = "회고"
        titleLabel.textColor = .mainBlack
        
        questionLabel.font = .myBoldSystemFont(ofSize: 21)
        questionLabel.textColor = .mainBlack
        
        limitCountLabel.font = .myRegularSystemFont(ofSize: 12)
        limitCountLabel.text = "/800자"
        limitCountLabel.textColor = .mainGray
        
        countNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        countNumberLabel.textColor = .mainOrange
    }
    
    private func setView() {
        writeView.backgroundColor = .mainLightGray
        writeView.layer.cornerRadius = 15
    }
    
    private func setTextView() {
        writeView.addSubview(writeTextView)
        
        writeTextView.leadingAnchor.constraint(equalTo: writeView.leadingAnchor, constant: 17).isActive = true
        writeTextView.trailingAnchor.constraint(equalTo: writeView.trailingAnchor, constant: -17).isActive = true
        writeTextView.topAnchor.constraint(equalTo: writeView.topAnchor, constant: 10).isActive = true
        textViewHeightConstraint = writeTextView.heightAnchor.constraint(equalToConstant: 477)
        textViewHeightConstraint?.isActive = true
        
        writeTextView.font = .myRegularSystemFont(ofSize: 16)
        writeTextView.textColor = .mainGray
        writeTextView.backgroundColor = UIColor.clear
        writeTextView.layer.cornerRadius = 10
        writeTextView.delegate = self
        writeTextView.isEditable = true
    }
    
    private func setButton() {
        saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        saveButton.setTitle("작성완료", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = 15
        buttonState()
    }
}

//MARK: Button
extension RetrospectiveWriteVC {
    private func buttonState() {
        guard let text: String = writeTextView.text else {return}
        if text != "" && text != cellPlaceholders[0] && text != cellPlaceholders[1] && text != cellPlaceholders[2] && text != contentSaver {
            saveButton.backgroundColor = .mainOrange
            saveButton.isEnabled = true
        } else {
            saveButton.backgroundColor = .mainGray
            saveButton.isEnabled = false
        }
    }
}

//MARK: Data
extension RetrospectiveWriteVC {
    private func setData() {
        let userDefault = UserDefaults.standard
        
        if let question = userDefault.string(forKey: "title") {
            questionLabel.text = question
        }
        
        if let content = userDefault.string(forKey: "content") {
            writeTextView.text = content
            if content != cellPlaceholders[0] && content != cellPlaceholders[1] && content != cellPlaceholders[2] {
                writeTextView.textColor = .mainBlack
                contentSaver = content
            } else {
                writeTextView.textColor = .mainGray
            }
        }
        
        if let count = userDefault.string(forKey: "count") {
            countNumberLabel.text = count
            counter = Int(count) ?? 0
        }
        
        cellNum = userDefault.integer(forKey: "cellNum")
    }
}

//MARK: TextView
extension RetrospectiveWriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if UIScreen.main.bounds.size.height <= 667 {
            textViewHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2.5
        } else if UIScreen.main.bounds.size.height <= 812 {
            textViewHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2.7
        } else if UIScreen.main.bounds.size.height <= 844 {
            textViewHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2.5
        } else {
            textViewHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2.3
        }
        
        guard let text: String = writeTextView.text else {return}
        if text == cellPlaceholders[cellNum] {
            writeTextView.text = ""
            writeTextView.textColor = .mainBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewHeightConstraint?.constant = 477
        
        guard let text: String = writeTextView.text else {return}
        if text == "" {
            writeTextView.text = cellPlaceholders[cellNum]
            writeTextView.textColor = .mainGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        buttonState()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        counter = newText.count
        countNumberLabel.text = "\(newText.count)"
        return numberOfChars < 800
    }
}

//MARK: Keyboard
extension RetrospectiveWriteVC {
    private func setKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissGestureKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissGestureKeyboard() {
        view.endEditing(true)
    }
}
