//
//  RetrospectiveWriteVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/05.
//

import UIKit

class RetrospectiveWriteVC: UIViewController {
    static let identifier = "RetrospectiveWriteVC"
    
    var saveContent: ((String, Int) -> ())?

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
    
    var cellPlaceholders = ["이번주, 어떤 내 모습을 칭찬 해주고 싶나요?", "한 주에 아쉬움이 남은 점이 있을까요?", "다음주에는 어떻게 지내고 싶은가요?"]
    
    var flowHeightConstraint: NSLayoutConstraint?
    
    var isFillIn = false
    var contentSaver = ""
    var counter = 0
    var cellNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setView()
        setTextView()
        setTabBar()
        setButton()
        setData()
        setKeyboard()
    }
    
    @IBAction func touchUpSave(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
        
        guard let text: String = writeTextView.text else {return}
        saveContent?(text, counter)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.popViewController(animated: true)
    }
}

extension RetrospectiveWriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let text: String = writeTextView.text else {return}
        if UIScreen.main.bounds.size.height <= 2340 {
            flowHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2.5
        } else if UIScreen.main.bounds.size.height <= 2532 {
            flowHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2.7
        } else {
            flowHeightConstraint?.constant = UIScreen.main.bounds.size.height / 2
        }
        if text == cellPlaceholders[cellNum] {
            writeTextView.text = ""
            writeTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        flowHeightConstraint?.constant = 471
        guard let text: String = writeTextView.text else {return}
        if text == "" {
            writeTextView.text = cellPlaceholders[cellNum]
            writeTextView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        setButton()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        counter = newText.count
        countNumberLabel.text = "\(newText.count)"
        return numberOfChars < 800
    }
}

extension RetrospectiveWriteVC {
    private func setData() {
        let userDefault = UserDefaults.standard
        
        if let question = userDefault.string(forKey: "title") {
            questionLabel.text = question
        }
        
        if let content = userDefault.string(forKey: "content") {
            writeTextView.text = content
            if content != cellPlaceholders[0] && content != cellPlaceholders[1] && content != cellPlaceholders[2] {
                writeTextView.textColor = .black
                contentSaver = content
            } else {
                writeTextView.textColor = .lightGray
            }
        }
        
        if let count = userDefault.string(forKey: "count") {
            countNumberLabel.text = count
            counter = Int(count) ?? 0
        }
        
        cellNum = userDefault.integer(forKey: "cellNum")
    }
    
    private func setTabBar() {
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setLabel() {
        titleLabel.text = "회고"
        titleLabel.font = .boldSystemFont(ofSize: 21)
        questionLabel.font = .boldSystemFont(ofSize: 21)
        limitCountLabel.text = "/800자"
        limitCountLabel.font = .systemFont(ofSize: 12)
        limitCountLabel.textColor = .lightGray
        countNumberLabel.font = .systemFont(ofSize: 12)
        countNumberLabel.textColor = .systemRed
    }
    
    private func setView() {
        writeView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        writeView.layer.cornerRadius = 15
    }
    
    private func setTextView() {
        writeView.addSubview(writeTextView)
        writeTextView.leadingAnchor.constraint(equalTo: writeView.leadingAnchor, constant: 17).isActive = true
        writeTextView.trailingAnchor.constraint(equalTo: writeView.trailingAnchor, constant: -17).isActive = true
        writeTextView.topAnchor.constraint(equalTo: writeView.topAnchor, constant: 16).isActive = true
        flowHeightConstraint = writeTextView.heightAnchor.constraint(equalToConstant: 471)
        flowHeightConstraint?.isActive = true
        
        writeTextView.delegate = self
        writeTextView.isEditable = true
        writeTextView.layer.cornerRadius = 10
        writeTextView.backgroundColor = UIColor.clear
        
        writeTextView.font = .systemFont(ofSize: 16)
        writeTextView.textColor = .lightGray
    }
    
    private func setButton() {
        saveButton.setTitle("작성완료", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = 15
        
        guard let text: String = writeTextView.text else {return}
        if text != "" && text != cellPlaceholders[0] && text != cellPlaceholders[1] && text != cellPlaceholders[2] && text != contentSaver {
            saveButton.backgroundColor = .systemRed
            saveButton.isEnabled = true
        } else {
            saveButton.backgroundColor = .lightGray
            saveButton.isEnabled = false
        }
    }
}

extension RetrospectiveWriteVC {
    private func setKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissGestureKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissGestureKeyboard() {
        view.endEditing(true)
    }
}
