//
//  RetrospectiveWriteTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/04.
//

import UIKit

class RetrospectiveWriteTVC: UITableViewCell {
    static let identifier = "RetrospectiveWriteTVC"

    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var limitNumberLabel: UILabel!
    @IBOutlet weak var countNumberLabel: UILabel!
    
    var delegate: UITableView?
    
    var placeholder = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RetrospectiveWriteTVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .black
        
        if textView.text == placeholder {
            textView.text = ""
            textView.bounds.size.height = UIScreen.main.bounds.height / 3
            delegate?.rowHeight = textView.bounds.size.height + 62
            delegate?.beginUpdates()
            delegate?.endUpdates()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = .lightGray
            textView.text = placeholder
            delegate?.rowHeight = (UIScreen.main.bounds.size.height - 150 - 104)/3
            delegate?.beginUpdates()
            delegate?.endUpdates()
        } else {
            
        }
    }
}

extension RetrospectiveWriteTVC {
    func setLabelData(title: String, placeholder: String) {
        self.placeholder = placeholder
        titleLabel.text = title
        writeTextView.text = self.placeholder
        writeTextView.textColor = .lightGray
    }
    
    private func setLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 21)
        limitNumberLabel.font = .systemFont(ofSize: 12)
        limitNumberLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        limitNumberLabel.text = "/800자"
        countNumberLabel.font = .systemFont(ofSize: 12)
        countNumberLabel.textColor = .systemRed
        countNumberLabel.text = "0"
    }
    
    private func setTextView() {
        writeTextView.delegate = self
        writeTextView.layer.cornerRadius = 10
        writeTextView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        writeTextView.textContainerInset.left = 16
        writeTextView.textContainerInset.right = 16
        writeTextView.textContainerInset.bottom = 16
        writeTextView.textContainerInset.top = 16
    }
}
