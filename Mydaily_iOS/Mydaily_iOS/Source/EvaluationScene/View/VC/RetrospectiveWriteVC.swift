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

    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var placeHolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextView()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        saveContent?(writeTextView.text)
        dismiss(animated: true, completion: nil)
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
    func setLabel(title: String, placeholder: String) {
        placeHolder = placeholder
        titleLabel.text = title
        writeTextView.text = placeholder
    }
    
    private func setTextView() {
        writeTextView.delegate = self
        writeTextView.layer.cornerRadius = 10
        writeTextView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        writeTextView.textContainerInset.left = 16
        writeTextView.textContainerInset.right = 16
        writeTextView.textContainerInset.bottom = 16
        writeTextView.textContainerInset.top = 16
        
        if writeTextView.text == placeHolder {
            writeTextView.textColor = .lightGray
        } else {
            writeTextView.textColor = .black
        }
    }
}
