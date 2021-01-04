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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RetrospectiveWriteTVC: UITextViewDelegate {}

extension RetrospectiveWriteTVC {
    func setLabelData(title: String, placeholder: String) {
        titleLabel.text = title
        writeTextView.text = placeholder
        writeTextView.textColor = UIColor.lightGray
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
        writeTextView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
