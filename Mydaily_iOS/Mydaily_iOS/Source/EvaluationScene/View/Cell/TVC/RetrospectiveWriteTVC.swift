//
//  RetrospectiveWriteTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/04.
//

import UIKit

class RetrospectiveWriteTVC: UITableViewCell {
    static let identifier = "RetrospectiveWriteTVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTwoLabel: UILabel!
    @IBOutlet weak var titleThreeLabel: UILabel!
    @IBOutlet weak var limitNumberLabel: UILabel!
    @IBOutlet weak var limitTwoNumberLabel: UILabel!
    @IBOutlet weak var limitThreeNumberLabel: UILabel!
    @IBOutlet weak var countNumberLabel: UILabel!
    @IBOutlet weak var countTwoNumberLabel: UILabel!
    @IBOutlet weak var countThreeNumberLabel: UILabel!
    @IBOutlet weak var contentOneTextViewButton: UIButton!
    @IBOutlet weak var contentTwoTextViewButton: UIButton!
    @IBOutlet weak var contentThreeTextViewButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var writeOneTextView: UITextView = {
        let writeOneTextView = UITextView()
        writeOneTextView.translatesAutoresizingMaskIntoConstraints = false
        return writeOneTextView
    }()
    
    lazy var writeTwoTextView: UITextView = {
        let writeTwoTextView = UITextView()
        writeTwoTextView.translatesAutoresizingMaskIntoConstraints = false
        return writeTwoTextView
    }()
    
    lazy var writeThreeTextView: UITextView = {
        let writeThreeTextView = UITextView()
        writeThreeTextView.translatesAutoresizingMaskIntoConstraints = false
        return writeThreeTextView
    }()
    
    var flowHeightConstraint: NSLayoutConstraint?
    var textHeightConstraint: NSLayoutConstraint?
    
    var delegate: TableViewInsideCollectionViewDelegate?
    var tableView: UITableView?
    
    var isFillInOne = false
    var isFillInTwo = false
    var isFillInThree = false
    
    var cellTitles = ["이번주의 잘 한 점", "이번주 아쉬운 점", "다음주에 임하는 마음가짐"]
    var cellPlaceholders = ["이번주, 어떤 내 모습을 칭찬 해주고 싶나요?", "한 주에 아쉬움이 남은 점이 있을까요?", "다음주에는 어떻게 지내고 싶은가요?"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        setLabel()
        setButtonView()
        setTextView()
        setSaveButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func touchUpTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        //dvc.setLabel(title: titleText, placeholder: placeholderText)
        dvc.saveContent = { text in
            if text == "" {
                self.writeOneTextView.textColor = UIColor.black.withAlphaComponent(0.3)
            } else {
                self.writeOneTextView.textColor = .black
            }
            self.writeOneTextView.text = text
            self.writeOneTextView.bounds.size.height = 328
        }
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpShameTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        //dvc.setLabel(title: titleText, placeholder: placeholderText)
        dvc.saveContent = { text in
            if text == "" {
                self.writeOneTextView.textColor = UIColor.black.withAlphaComponent(0.3)
            } else {
                self.writeOneTextView.textColor = .black
            }
            self.writeOneTextView.text = text
            self.writeOneTextView.bounds.size.height = 328
        }
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpPromiseTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        //dvc.setLabel(title: titleText, placeholder: placeholderText)
        dvc.saveContent = { text in
            if text == "" {
                self.writeOneTextView.textColor = UIColor.black.withAlphaComponent(0.3)
            } else {
                self.writeOneTextView.textColor = .black
            }
            self.writeOneTextView.text = text
            self.writeOneTextView.bounds.size.height = 328
        }
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
}

extension RetrospectiveWriteTVC: UITextViewDelegate {}

extension RetrospectiveWriteTVC {
    private func setLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 21)
        titleLabel.text = cellTitles[0]
        titleTwoLabel.font = .boldSystemFont(ofSize: 21)
        titleTwoLabel.text = cellTitles[1]
        titleThreeLabel.font = .boldSystemFont(ofSize: 21)
        titleThreeLabel.text = cellTitles[2]
        
        limitNumberLabel.font = .systemFont(ofSize: 12)
        limitNumberLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        limitNumberLabel.text = "/800자"
        limitTwoNumberLabel.font = .systemFont(ofSize: 12)
        limitTwoNumberLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        limitTwoNumberLabel.text = "/800자"
        limitThreeNumberLabel.font = .systemFont(ofSize: 12)
        limitThreeNumberLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        limitThreeNumberLabel.text = "/800자"
        
        countNumberLabel.font = .systemFont(ofSize: 12)
        countNumberLabel.textColor = .systemRed
        countNumberLabel.text = "0"
        countTwoNumberLabel.font = .systemFont(ofSize: 12)
        countTwoNumberLabel.textColor = .systemRed
        countTwoNumberLabel.text = "0"
        countThreeNumberLabel.font = .systemFont(ofSize: 12)
        countThreeNumberLabel.textColor = .systemRed
        countThreeNumberLabel.text = "0"
    }
    
    private func setSaveButton() {
        if isFillInOne && isFillInTwo && isFillInThree {
            saveButton.backgroundColor = .systemRed
            saveButton.layer.masksToBounds = true
            saveButton.layer.cornerRadius = 15
            saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
            saveButton.setTitle("회고완료!", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.isEnabled = true
        } else {
            saveButton.backgroundColor = .lightGray
            saveButton.layer.masksToBounds = true
            saveButton.layer.cornerRadius = 15
            saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
            saveButton.setTitle("회고완료!", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.isEnabled = false
        }
    }
}

extension RetrospectiveWriteTVC {
    private func setButtonView() {
        setOneButtonView()
        setTwoButtonView()
        setThreeButtonView()
    }
    
    private func setOneButtonView() {
        contentOneTextViewButton.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        contentOneTextViewButton.layer.cornerRadius = 10
        contentOneTextViewButton.layer.masksToBounds = true
        contentOneTextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        contentOneTextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        flowHeightConstraint = contentOneTextViewButton.heightAnchor.constraint(equalToConstant: 104)
        flowHeightConstraint?.isActive = true
        contentOneTextViewButton.isHighlighted = false
    }
    
    private func setTwoButtonView() {
        contentTwoTextViewButton.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        contentTwoTextViewButton.layer.cornerRadius = 10
        contentTwoTextViewButton.layer.masksToBounds = true
        contentTwoTextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        contentTwoTextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        flowHeightConstraint = contentTwoTextViewButton.heightAnchor.constraint(equalToConstant: 104)
        flowHeightConstraint?.isActive = true
        contentTwoTextViewButton.isHighlighted = false
    }
    
    private func setThreeButtonView() {
        contentThreeTextViewButton.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        contentThreeTextViewButton.layer.cornerRadius = 10
        contentThreeTextViewButton.layer.masksToBounds = true
        contentThreeTextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        contentThreeTextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        flowHeightConstraint = contentThreeTextViewButton.heightAnchor.constraint(equalToConstant: 104)
        flowHeightConstraint?.isActive = true
        contentThreeTextViewButton.isHighlighted = false
    }
}

extension RetrospectiveWriteTVC {
    private func setTextView() {
        setOneTextView()
        setTwoTextView()
        setThreeTextView()
    }
    
    private func setOneTextView() {
        contentOneTextViewButton.addSubview(writeOneTextView)
        writeOneTextView.leadingAnchor.constraint(equalTo: contentOneTextViewButton.leadingAnchor, constant: 17).isActive = true
        writeOneTextView.trailingAnchor.constraint(equalTo: contentOneTextViewButton.trailingAnchor, constant: -17).isActive = true
        writeOneTextView.topAnchor.constraint(equalTo: contentOneTextViewButton.topAnchor, constant: 16).isActive = true
        writeOneTextView.bottomAnchor.constraint(equalTo: contentOneTextViewButton.bottomAnchor, constant: -16).isActive = true
        
        writeOneTextView.isUserInteractionEnabled = false
        writeOneTextView.delegate = self
        writeOneTextView.isEditable = false
        writeOneTextView.layer.cornerRadius = 10
        writeOneTextView.backgroundColor = UIColor.clear
        
        writeOneTextView.font = .systemFont(ofSize: 16)
        writeOneTextView.text = cellPlaceholders[0]
        writeOneTextView.textColor = .lightGray
    }
    
    private func setTwoTextView() {
        contentTwoTextViewButton.addSubview(writeTwoTextView)
        writeTwoTextView.leadingAnchor.constraint(equalTo: contentTwoTextViewButton.leadingAnchor, constant: 17).isActive = true
        writeTwoTextView.trailingAnchor.constraint(equalTo: contentTwoTextViewButton.trailingAnchor, constant: -17).isActive = true
        writeTwoTextView.topAnchor.constraint(equalTo: contentTwoTextViewButton.topAnchor, constant: 16).isActive = true
        writeTwoTextView.bottomAnchor.constraint(equalTo: contentTwoTextViewButton.bottomAnchor, constant: -16).isActive = true
        
        writeTwoTextView.isUserInteractionEnabled = false
        writeTwoTextView.delegate = self
        writeTwoTextView.isEditable = false
        writeTwoTextView.layer.cornerRadius = 10
        writeTwoTextView.backgroundColor = UIColor.clear
        
        writeTwoTextView.font = .systemFont(ofSize: 16)
        writeTwoTextView.text = cellPlaceholders[1]
        writeTwoTextView.textColor = .lightGray
    }
    
    private func setThreeTextView() {
        contentThreeTextViewButton.addSubview(writeThreeTextView)
        writeThreeTextView.leadingAnchor.constraint(equalTo: contentThreeTextViewButton.leadingAnchor, constant: 17).isActive = true
        writeThreeTextView.trailingAnchor.constraint(equalTo: contentThreeTextViewButton.trailingAnchor, constant: -17).isActive = true
        writeThreeTextView.topAnchor.constraint(equalTo: contentThreeTextViewButton.topAnchor, constant: 16).isActive = true
        writeThreeTextView.bottomAnchor.constraint(equalTo: contentThreeTextViewButton.bottomAnchor, constant: -16).isActive = true
        
        writeThreeTextView.isUserInteractionEnabled = false
        writeThreeTextView.delegate = self
        writeThreeTextView.isEditable = false
        writeThreeTextView.layer.cornerRadius = 10
        writeThreeTextView.backgroundColor = UIColor.clear
        
        writeThreeTextView.font = .systemFont(ofSize: 16)
        writeThreeTextView.text = cellPlaceholders[2]
        writeThreeTextView.textColor = .lightGray
    }
}
