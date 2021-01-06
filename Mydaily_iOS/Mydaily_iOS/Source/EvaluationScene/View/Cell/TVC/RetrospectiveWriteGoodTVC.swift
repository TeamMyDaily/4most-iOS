//
//  RetrospectiveWriteTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/04.
//

import UIKit

class RetrospectiveWriteGoodTVC: UITableViewCell {
    static let identifier = "RetrospectiveWriteGoodTVC"

    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var limitNumberLabel: UILabel!
    @IBOutlet weak var countNumberLabel: UILabel!
    
    var delegate: TableViewInsideCollectionViewDelegate?
    var tableView: UITableView?
    
    var titleText: String = ""
    var placeholderText: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        setLabel()
        let gesture =  UITapGestureRecognizer(target: self, action: #selector(selectView))
        writeTextView.addGestureRecognizer(gesture)
        writeTextView.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func selectView() {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        //dvc.setLabel(title: titleText, placeholder: placeholderText)
        dvc.saveContent = { text in
            if text == self.placeholderText {
                self.writeTextView.textColor = UIColor.black.withAlphaComponent(0.3)
            } else {
                self.writeTextView.textColor = .black
            }
            self.writeTextView.text = text
            self.writeTextView.bounds.size.height = 328
            self.tableView?.beginUpdates()
            self.tableView?.endUpdates()
        }
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
}

extension RetrospectiveWriteGoodTVC: UITextViewDelegate {}

extension RetrospectiveWriteGoodTVC {
    func setLabelData(title: String, placeholder: String) {
        titleLabel.text = title
        writeTextView.text = placeholder
        writeTextView.textColor = .lightGray
        titleText = title
        placeholderText = placeholder
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
        writeTextView.isEditable = false
        writeTextView.layer.cornerRadius = 10
        writeTextView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        writeTextView.scrollIndicatorInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 5)
        
  
        writeTextView.textContainerInset.left = 16
        writeTextView.textContainerInset.right = 16
        writeTextView.textContainerInset.bottom = 16
        writeTextView.textContainerInset.top = 16
    }
}
