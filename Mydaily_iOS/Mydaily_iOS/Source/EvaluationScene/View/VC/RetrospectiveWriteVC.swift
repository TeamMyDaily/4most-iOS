//
//  RetrospectiveWriteVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/05.
//

import UIKit

class RetrospectiveWriteVC: UIViewController {
    static let identifier = "RetrospectiveWriteVC"
    
    var saveContent: ((String) -> ())?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var limitCountLabel: UILabel!
    @IBOutlet weak var countNumberLabel: UILabel!
    @IBOutlet weak var writeView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
    }
    
    @IBAction func touchUpSave(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension RetrospectiveWriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeHolder
            textView.textColor = .lightGray
        }
    }
}

extension RetrospectiveWriteVC {
    func setData(question: String, content: String, countNum: Int) {
        
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
        writeView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8).isActive = true
        writeView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24).isActive = true
        writeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        writeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        writeView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
    }
    
    private func setTextView() {
//        writeTextView.delegate = self
//        writeTextView.layer.cornerRadius = 10
//        writeTextView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
//        writeTextView.textContainerInset.left = 16
//        writeTextView.textContainerInset.right = 16
//        writeTextView.textContainerInset.bottom = 16
//        writeTextView.textContainerInset.top = 16
//
//        if writeTextView.text == placeHolder {
//            writeTextView.textColor = .lightGray
//        } else {
//            writeTextView.textColor = .black
//        }
    }
}
