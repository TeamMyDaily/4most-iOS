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
    var flowHeightTwoConstraint: NSLayoutConstraint?
    var flowHeightThreeConstraint: NSLayoutConstraint?
    
    let userDefault = UserDefaults.standard
    
    var buttonDelegate: ChangeModifyButtonDelegate?
    var delegate: TableViewInsideCollectionViewDelegate?
    var tableView: UITableView?
    
    var isFillInOne = false
    var isFillInTwo = false
    var isFillInThree = false
    var isSaved = false
    
    var cellTitles = ["이번주의 잘 한 점", "이번주 아쉬운 점", "다음주에 임하는 마음가짐"]
    var cellPlaceholders = ["이번주, 어떤 내 모습을 칭찬 해주고 싶나요?", "한 주에 아쉬움이 남은 점이 있을까요?", "다음주에는 어떻게 지내고 싶은가요?"]
    var counts: [Int] = [0, 0, 0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        setLabel()
        setButtonView()
        setTextView()
        setSaveButton()
        setNotification()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func touchUpTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        dvc.saveContent = { text, textCount in
            if text == "" || text == self.cellPlaceholders[0] {
                self.contentOneTextViewButton.layer.borderWidth = 0
                self.contentOneTextViewButton.backgroundColor = .mainLightGray
                self.writeOneTextView.textColor = .mainGray
            } else {
                self.contentOneTextViewButton.layer.borderWidth = 1
                self.contentOneTextViewButton.layer.borderColor = UIColor.mainPaleOrange.cgColor
                self.contentOneTextViewButton.backgroundColor = .white
                
                self.writeOneTextView.textColor = .mainBlack
                self.writeOneTextView.text = text
                self.countNumberLabel.text = "\(textCount)"
                
                if self.flowHeightConstraint?.constant != 328 {
                    self.flowHeightConstraint?.constant = 328
                    self.tableView?.rowHeight += 224
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                }
                
                self.cellPlaceholders[0] = text
                self.counts[0] = textCount
                
                self.isFillInOne = true
                self.setSaveButton()
            }
        }
        userDefault.setValue(self.cellTitles[0], forKey: "title")
        userDefault.setValue(self.cellPlaceholders[0], forKey: "content")
        userDefault.setValue(self.counts[0], forKey: "count")
        userDefault.setValue(0, forKey: "cellNum")
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpShameTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        dvc.saveContent = { text, textCount in
            if text == "" || text == self.cellPlaceholders[1] {
                self.contentTwoTextViewButton.layer.borderWidth = 0
                self.contentTwoTextViewButton.backgroundColor = .mainLightGray
                self.writeTwoTextView.textColor = .mainGray
            } else {
                self.contentTwoTextViewButton.layer.borderWidth = 1
                self.contentTwoTextViewButton.layer.borderColor = UIColor.mainPaleOrange.cgColor
                self.contentTwoTextViewButton.backgroundColor = .white
                
                self.writeTwoTextView.textColor = .mainBlack
                self.writeTwoTextView.text = text
                self.countTwoNumberLabel.text = "\(textCount)"
                
                if self.flowHeightTwoConstraint?.constant != 328 {
                    self.flowHeightTwoConstraint?.constant = 328
                    self.tableView?.rowHeight += 224
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                }
                
                self.cellPlaceholders[1] = text
                self.counts[1] = textCount
                
                self.isFillInTwo = true
                self.setSaveButton()
            }
        }
        userDefault.setValue(self.cellTitles[1], forKey: "title")
        userDefault.setValue(self.cellPlaceholders[1], forKey: "content")
        userDefault.setValue(self.counts[1], forKey: "count")
        userDefault.setValue(1, forKey: "cellNum")
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpPromiseTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        dvc.saveContent = { text, textCount in
            if text == "" || text == self.cellPlaceholders[2] {
                self.contentThreeTextViewButton.layer.borderWidth = 0
                self.contentThreeTextViewButton.backgroundColor = .mainLightGray
                self.writeThreeTextView.textColor = .mainGray
            } else {
                self.contentThreeTextViewButton.layer.borderWidth = 1
                self.contentThreeTextViewButton.layer.borderColor = UIColor.mainPaleOrange.cgColor
                self.contentThreeTextViewButton.backgroundColor = .white
                
                self.writeThreeTextView.textColor = .mainBlack
                self.writeThreeTextView.text = text
                self.countThreeNumberLabel.text = "\(textCount)"
                
                if self.flowHeightThreeConstraint?.constant != 328 {
                    self.flowHeightThreeConstraint?.constant = 328
                    self.tableView?.rowHeight += 224
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                }
                
                self.cellPlaceholders[2] = text
                self.counts[2] = textCount
                
                self.isFillInThree = true
                self.setSaveButton()
            }
        }
        userDefault.setValue(self.cellTitles[2], forKey: "title")
        userDefault.setValue(self.cellPlaceholders[2], forKey: "content")
        userDefault.setValue(self.counts[2], forKey: "count")
        userDefault.setValue(2, forKey: "cellNum")
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpSave(_ sender: Any) {
        buttonDelegate?.changeModifyButton(isActive: false)
        tableView?.rowHeight -= 50
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
        saveButton.isHidden = true
        isSaved = true
        buttonDelegate?.showAlert(title: "목표를 재설정 하시겠어요?", message: "한주의 회고를 다 마치셨군요!\n 목표를 달성하셨다면 새로운 목표로 재설정 하시겠어요?")
    }
}

extension RetrospectiveWriteTVC: UITextViewDelegate {}

extension RetrospectiveWriteTVC {
    private func setLabel() {
        titleLabel.font = .myBoldSystemFont(ofSize: 21)
        titleLabel.textColor = .mainBlack
        titleLabel.text = cellTitles[0]
        titleTwoLabel.font = .myBoldSystemFont(ofSize: 21)
        titleTwoLabel.textColor = .mainBlack
        titleTwoLabel.text = cellTitles[1]
        titleThreeLabel.font = .myBoldSystemFont(ofSize: 21)
        titleThreeLabel.textColor = .mainBlack
        titleThreeLabel.text = cellTitles[2]
        
        limitNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        limitNumberLabel.textColor = .mainGray
        limitNumberLabel.text = "/800자"
        limitTwoNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        limitTwoNumberLabel.textColor = .mainGray
        limitTwoNumberLabel.text = "/800자"
        limitThreeNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        limitThreeNumberLabel.textColor = .mainGray
        limitThreeNumberLabel.text = "/800자"
        
        countNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        countNumberLabel.textColor = .mainOrange
        countNumberLabel.text = "0"
        countTwoNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        countTwoNumberLabel.textColor = .mainOrange
        countTwoNumberLabel.text = "0"
        countThreeNumberLabel.font = .myRegularSystemFont(ofSize: 12)
        countThreeNumberLabel.textColor = .mainOrange
        countThreeNumberLabel.text = "0"
    }
    
    private func setSaveButton() {
        if !isSaved {
            if isFillInOne && isFillInTwo && isFillInThree {
                saveButton.backgroundColor = .mainOrange
                saveButton.layer.masksToBounds = true
                saveButton.layer.cornerRadius = 15
                saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
                saveButton.setTitle("회고완료!", for: .normal)
                saveButton.setTitleColor(.white, for: .normal)
                saveButton.isEnabled = true
            } else {
                saveButton.backgroundColor = .mainGray
                saveButton.layer.masksToBounds = true
                saveButton.layer.cornerRadius = 15
                saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
                saveButton.setTitle("회고완료!", for: .normal)
                saveButton.setTitleColor(.white, for: .normal)
                saveButton.isEnabled = false
            }
        }
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenSaveButton), name: Notification.Name(rawValue: "modifyButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectRetrospectiveTab(_:)), name: Notification.Name(rawValue: "retrospectiveTab"), object: nil)
    }
    
    @objc func hiddenSaveButton() {
        tableView?.rowHeight += 50
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
        saveButton.layer.isHidden = false
        isSaved = false
    }
    
    @objc func selectRetrospectiveTab(_ notification: NSNotification) {
        let getButton = notification.object as! UIButton
        if isSaved {
            getButton.isHidden = false
        } else {
            getButton.isHidden = true
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
        contentOneTextViewButton.backgroundColor = .mainLightGray
        contentOneTextViewButton.layer.cornerRadius = 10
        contentOneTextViewButton.layer.masksToBounds = true
        contentOneTextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        contentOneTextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        print(UIScreen.main.bounds.size.height)
        if UIScreen.main.bounds.size.height <= 667 {
            flowHeightConstraint = contentOneTextViewButton.heightAnchor.constraint(equalToConstant: 84)
        } else {
            flowHeightConstraint = contentOneTextViewButton.heightAnchor.constraint(equalToConstant: 104)
        }
        flowHeightConstraint?.isActive = true
        contentOneTextViewButton.isHighlighted = false
    }
    
    private func setTwoButtonView() {
        contentTwoTextViewButton.backgroundColor = .mainLightGray
        contentTwoTextViewButton.layer.cornerRadius = 10
        contentTwoTextViewButton.layer.masksToBounds = true
        contentTwoTextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        contentTwoTextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        if UIScreen.main.bounds.size.height <= 667 {
            flowHeightTwoConstraint = contentTwoTextViewButton.heightAnchor.constraint(equalToConstant: 84)
        } else {
            flowHeightTwoConstraint = contentTwoTextViewButton.heightAnchor.constraint(equalToConstant: 104)
        }
        flowHeightTwoConstraint?.isActive = true
        contentTwoTextViewButton.isHighlighted = false
    }
    
    private func setThreeButtonView() {
        contentThreeTextViewButton.backgroundColor = .mainLightGray
        contentThreeTextViewButton.layer.cornerRadius = 10
        contentThreeTextViewButton.layer.masksToBounds = true
        contentThreeTextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        contentThreeTextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        if UIScreen.main.bounds.size.height <= 667 {
            flowHeightThreeConstraint = contentThreeTextViewButton.heightAnchor.constraint(equalToConstant: 84)
        } else {
            flowHeightThreeConstraint = contentThreeTextViewButton.heightAnchor.constraint(equalToConstant: 104)
        }
        flowHeightThreeConstraint?.isActive = true
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
        writeOneTextView.leadingAnchor.constraint(equalTo: contentOneTextViewButton.leadingAnchor, constant: 14).isActive = true
        writeOneTextView.trailingAnchor.constraint(equalTo: contentOneTextViewButton.trailingAnchor, constant: -14).isActive = true
        writeOneTextView.topAnchor.constraint(equalTo: contentOneTextViewButton.topAnchor, constant: 11).isActive = true
        writeOneTextView.bottomAnchor.constraint(equalTo: contentOneTextViewButton.bottomAnchor, constant: -11).isActive = true
        
        writeOneTextView.delegate = self
        writeOneTextView.isEditable = false
        writeOneTextView.layer.cornerRadius = 12
        writeOneTextView.backgroundColor = UIColor.clear
        writeOneTextView.autocapitalizationType = .none
        writeOneTextView.autocorrectionType = .no
        writeOneTextView.smartDashesType = .no
        writeOneTextView.smartInsertDeleteType = .no
        writeOneTextView.spellCheckingType = .no
        
        writeOneTextView.font = .myRegularSystemFont(ofSize: 16)
        writeOneTextView.text = cellPlaceholders[0]
        writeOneTextView.textColor = .mainGray
    }
    
    private func setTwoTextView() {
        contentTwoTextViewButton.addSubview(writeTwoTextView)
        writeTwoTextView.leadingAnchor.constraint(equalTo: contentTwoTextViewButton.leadingAnchor, constant: 14).isActive = true
        writeTwoTextView.trailingAnchor.constraint(equalTo: contentTwoTextViewButton.trailingAnchor, constant: -14).isActive = true
        writeTwoTextView.topAnchor.constraint(equalTo: contentTwoTextViewButton.topAnchor, constant: 11).isActive = true
        writeTwoTextView.bottomAnchor.constraint(equalTo: contentTwoTextViewButton.bottomAnchor, constant: -11).isActive = true
        
        writeTwoTextView.delegate = self
        writeTwoTextView.isEditable = false
        writeTwoTextView.layer.cornerRadius = 12
        writeTwoTextView.backgroundColor = UIColor.clear
        writeTwoTextView.autocapitalizationType = .none
        writeTwoTextView.autocorrectionType = .no
        writeTwoTextView.smartDashesType = .no
        writeTwoTextView.smartInsertDeleteType = .no
        writeTwoTextView.spellCheckingType = .no
        
        writeTwoTextView.font = .myRegularSystemFont(ofSize: 16)
        writeTwoTextView.text = cellPlaceholders[1]
        writeTwoTextView.textColor = .mainGray
    }
    
    private func setThreeTextView() {
        contentThreeTextViewButton.addSubview(writeThreeTextView)
        writeThreeTextView.leadingAnchor.constraint(equalTo: contentThreeTextViewButton.leadingAnchor, constant: 14).isActive = true
        writeThreeTextView.trailingAnchor.constraint(equalTo: contentThreeTextViewButton.trailingAnchor, constant: -14).isActive = true
        writeThreeTextView.topAnchor.constraint(equalTo: contentThreeTextViewButton.topAnchor, constant: 11).isActive = true
        writeThreeTextView.bottomAnchor.constraint(equalTo: contentThreeTextViewButton.bottomAnchor, constant: -11).isActive = true
        
        writeThreeTextView.delegate = self
        writeThreeTextView.isEditable = false
        writeThreeTextView.layer.cornerRadius = 12
        writeThreeTextView.backgroundColor = UIColor.clear
        writeThreeTextView.autocapitalizationType = .none
        writeThreeTextView.autocorrectionType = .no
        writeThreeTextView.smartDashesType = .no
        writeThreeTextView.smartInsertDeleteType = .no
        writeThreeTextView.spellCheckingType = .no
        
        writeThreeTextView.font = .myRegularSystemFont(ofSize: 16)
        writeThreeTextView.text = cellPlaceholders[2]
        writeThreeTextView.textColor = .mainGray
    }
}
