//
//  RetrospectiveWriteTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/04.
//

import UIKit

class RetrospectiveWriteTVC: UITableViewCell {
    static let identifier = "RetrospectiveWriteTVC"

    @IBOutlet weak var goodTitleLabel: UILabel!
    @IBOutlet weak var badTitleLabel: UILabel!
    @IBOutlet weak var nextTitleLabel: UILabel!
    @IBOutlet weak var goodLimitLabel: UILabel!
    @IBOutlet weak var badLimitLabel: UILabel!
    @IBOutlet weak var nextLimitLabel: UILabel!
    @IBOutlet weak var goodCounterLabel: UILabel!
    @IBOutlet weak var badCounterLabel: UILabel!
    @IBOutlet weak var nextCounterLabel: UILabel!
    @IBOutlet weak var goodViewButton: UIButton!
    @IBOutlet weak var badViewButton: UIButton!
    @IBOutlet weak var nextViewButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var goodTextView: UITextView = {
        let goodTextView = UITextView()
        goodTextView.translatesAutoresizingMaskIntoConstraints = false
        return goodTextView
    }()
    
    lazy var badTextView: UITextView = {
        let badTextView = UITextView()
        badTextView.translatesAutoresizingMaskIntoConstraints = false
        return badTextView
    }()
    
    lazy var nextTextView: UITextView = {
        let nextTextView = UITextView()
        nextTextView.translatesAutoresizingMaskIntoConstraints = false
        return nextTextView
    }()
    
    var buttonDelegate: OccurWhenClickModifyButtonDelegate?
    var delegate: TableViewInsideCollectionViewDelegate?
    var tableView: UITableView?
    
    var goodViewHeightConstraint: NSLayoutConstraint?
    var badViewHeightConstraint: NSLayoutConstraint?
    var nextViewHeightConstraint: NSLayoutConstraint?
    var goodTextViewHeightConstraint: NSLayoutConstraint?
    var badTextViewHeightConstraint: NSLayoutConstraint?
    var nextTextViewHeightConstraint: NSLayoutConstraint?
    
    let userDefault = UserDefaults.standard
    
    var isGoodFilled = false
    var isBadFilled = false
    var isNextFilled = false
    var isSaved = false
    
    var cellTitles = ["이번주의 잘 한 점", "이번주 아쉬운 점", "다음주에 임하는 마음가짐"]
    var cellPlaceholders = ["이번주, 어떤 내 모습을 칭찬 해주고 싶나요?", "한 주에 아쉬움이 남은 점이 있을까요?", "다음주에는 어떻게 지내고 싶은가요?"]
    var counts: [Int] = [0, 0, 0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        setNotification()
        setSaveButton()
        setButtonViews()
        setTextViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: Action
extension RetrospectiveWriteTVC {
    @IBAction func touchUpGoodTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        dvc.saveContent = { text, textCount in
            if text == "" || text == self.cellPlaceholders[0] {
                self.goodViewButton.layer.borderWidth = 0
                self.goodViewButton.backgroundColor = .mainLightGray
                
                self.goodTextView.textColor = .mainGray
            } else {
                self.goodViewButton.layer.borderWidth = 1
                self.goodViewButton.layer.borderColor = UIColor.mainPaleOrange.cgColor
                self.goodViewButton.backgroundColor = .white
                
                self.goodTextView.isUserInteractionEnabled = true
                self.goodTextView.text = text
                self.goodTextView.textColor = .mainBlack
                
                self.goodCounterLabel.text = "\(textCount)"
                
                if self.goodViewHeightConstraint?.constant != 328 {
                    self.goodViewHeightConstraint?.constant = 328
                    self.tableView?.rowHeight += 224
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                }
                
                self.cellPlaceholders[0] = text
                self.counts[0] = textCount
                self.isGoodFilled = true
                
                self.setSaveButton()
            }
        }
        userDefault.setValue(self.cellTitles[0], forKey: "title")
        userDefault.setValue(self.cellPlaceholders[0], forKey: "content")
        userDefault.setValue(self.counts[0], forKey: "count")
        userDefault.setValue(0, forKey: "cellNum")
        
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpBadTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        dvc.saveContent = { text, textCount in
            if text == "" || text == self.cellPlaceholders[1] {
                self.badViewButton.layer.borderWidth = 0
                self.badViewButton.backgroundColor = .mainLightGray
                
                self.badTextView.textColor = .mainGray
            } else {
                self.badViewButton.layer.borderWidth = 1
                self.badViewButton.layer.borderColor = UIColor.mainPaleOrange.cgColor
                self.badViewButton.backgroundColor = .white
                
                self.badTextView.isUserInteractionEnabled = true
                self.badTextView.textColor = .mainBlack
                self.badTextView.text = text
                
                self.badCounterLabel.text = "\(textCount)"
                
                if self.badViewHeightConstraint?.constant != 328 {
                    self.badViewHeightConstraint?.constant = 328
                    self.tableView?.rowHeight += 224
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                }
                
                self.cellPlaceholders[1] = text
                self.counts[1] = textCount
                self.isBadFilled = true
                
                self.setSaveButton()
            }
        }
        userDefault.setValue(self.cellTitles[1], forKey: "title")
        userDefault.setValue(self.cellPlaceholders[1], forKey: "content")
        userDefault.setValue(self.counts[1], forKey: "count")
        userDefault.setValue(1, forKey: "cellNum")
        
        delegate?.cellTapedRetrospective(dvc: dvc)
    }
    
    @IBAction func touchUpNextTextView(_ sender: Any) {
        guard let dvc =  UIStoryboard.init(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "RetrospectiveWriteVC") as? RetrospectiveWriteVC else {
            return
        }
        dvc.saveContent = { text, textCount in
            if text == "" || text == self.cellPlaceholders[2] {
                self.nextViewButton.layer.borderWidth = 0
                self.nextViewButton.backgroundColor = .mainLightGray
                
                self.nextTextView.textColor = .mainGray
            } else {
                self.nextViewButton.layer.borderWidth = 1
                self.nextViewButton.layer.borderColor = UIColor.mainPaleOrange.cgColor
                self.nextViewButton.backgroundColor = .white
                
                self.nextTextView.isUserInteractionEnabled = true
                self.nextTextView.textColor = .mainBlack
                self.nextTextView.text = text
                
                self.nextCounterLabel.text = "\(textCount)"
                
                if self.nextViewHeightConstraint?.constant != 328 {
                    self.nextViewHeightConstraint?.constant = 328
                    self.tableView?.rowHeight += 224
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                }
                
                self.cellPlaceholders[2] = text
                self.counts[2] = textCount
                self.isNextFilled = true
                
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
        buttonDelegate?.showAlert(title: "목표를 재설정 하시겠어요?", message: "한주의 회고를 다 마치셨군요!\n 목표를 달성하셨다면 새로운 목표로 재설정 하시겠어요?")
        
        tableView?.rowHeight -= 50
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
        
        saveButton.isHidden = true
        isSaved = true
        goodViewButton.isUserInteractionEnabled = false
        badViewButton.isUserInteractionEnabled = false
        nextViewButton.isUserInteractionEnabled = false
    }
}

//MARK: Label
extension RetrospectiveWriteTVC {
    private func setLabel() {
        setTitleLabel()
        setCountLabel()
    }
    
    private func setTitleLabel() {
        goodTitleLabel.font = .myBoldSystemFont(ofSize: 21)
        goodTitleLabel.text = cellTitles[0]
        goodTitleLabel.textColor = .mainBlack
        
        badTitleLabel.font = .myBoldSystemFont(ofSize: 21)
        badTitleLabel.text = cellTitles[1]
        badTitleLabel.textColor = .mainBlack
        
        nextTitleLabel.font = .myBoldSystemFont(ofSize: 21)
        nextTitleLabel.text = cellTitles[2]
        nextTitleLabel.textColor = .mainBlack
    }
    
    private func setCountLabel() {
        goodLimitLabel.font = .myRegularSystemFont(ofSize: 12)
        goodLimitLabel.text = "/800자"
        goodLimitLabel.textColor = .mainGray
        
        badLimitLabel.font = .myRegularSystemFont(ofSize: 12)
        badLimitLabel.text = "/800자"
        badLimitLabel.textColor = .mainGray
        
        nextLimitLabel.font = .myRegularSystemFont(ofSize: 12)
        nextLimitLabel.text = "/800자"
        nextLimitLabel.textColor = .mainGray
        
        goodCounterLabel.font = .myRegularSystemFont(ofSize: 12)
        goodCounterLabel.text = "0"
        goodCounterLabel.textColor = .mainOrange
        
        badCounterLabel.font = .myRegularSystemFont(ofSize: 12)
        badCounterLabel.text = "0"
        badCounterLabel.textColor = .mainOrange
        
        nextCounterLabel.font = .myRegularSystemFont(ofSize: 12)
        nextCounterLabel.text = "0"
        nextCounterLabel.textColor = .mainOrange
    }
}

//MARK: Notification
extension RetrospectiveWriteTVC {
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
        goodViewButton.isUserInteractionEnabled = true
        badViewButton.isUserInteractionEnabled = true
        nextViewButton.isUserInteractionEnabled = true
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

//MARK: Button
extension RetrospectiveWriteTVC {
    private func setSaveButton() {
        if !isSaved {
            if isGoodFilled && isBadFilled && isNextFilled {
                saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
                saveButton.setTitle("회고완료!", for: .normal)
                saveButton.setTitleColor(.white, for: .normal)
                saveButton.backgroundColor = .mainOrange
                saveButton.layer.masksToBounds = true
                saveButton.layer.cornerRadius = 15
                saveButton.isEnabled = true
            } else {
                saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
                saveButton.setTitle("회고완료!", for: .normal)
                saveButton.setTitleColor(.white, for: .normal)
                saveButton.backgroundColor = .mainGray
                saveButton.layer.masksToBounds = true
                saveButton.layer.cornerRadius = 15
                saveButton.isEnabled = false
            }
        }
    }
    
    private func setButtonViews() {
        setGoodButtonView()
        setBadButtonView()
        setNextButtonView()
    }
    
    private func setGoodButtonView() {
        goodViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        goodViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        if UIScreen.main.bounds.size.height <= 667 {
            goodViewHeightConstraint = goodViewButton.heightAnchor.constraint(equalToConstant: 84)
        } else {
            goodViewHeightConstraint = goodViewButton.heightAnchor.constraint(equalToConstant: 104)
        }
        goodViewHeightConstraint?.isActive = true
        goodViewButton.backgroundColor = .mainLightGray
        goodViewButton.layer.cornerRadius = 10
        goodViewButton.layer.masksToBounds = true
        goodViewButton.isHighlighted = false
    }
    
    private func setBadButtonView() {
        badViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        badViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        if UIScreen.main.bounds.size.height <= 667 {
            badViewHeightConstraint = badViewButton.heightAnchor.constraint(equalToConstant: 84)
        } else {
            badViewHeightConstraint = badViewButton.heightAnchor.constraint(equalToConstant: 104)
        }
        badViewHeightConstraint?.isActive = true
        badViewButton.backgroundColor = .mainLightGray
        badViewButton.layer.cornerRadius = 10
        badViewButton.layer.masksToBounds = true
        badViewButton.isHighlighted = false
    }
    
    private func setNextButtonView() {
        nextViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        nextViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        if UIScreen.main.bounds.size.height <= 667 {
            nextViewHeightConstraint = nextViewButton.heightAnchor.constraint(equalToConstant: 84)
        } else {
            nextViewHeightConstraint = nextViewButton.heightAnchor.constraint(equalToConstant: 104)
        }
        nextViewHeightConstraint?.isActive = true
        nextViewButton.backgroundColor = .mainLightGray
        nextViewButton.layer.cornerRadius = 10
        nextViewButton.layer.masksToBounds = true
        nextViewButton.isHighlighted = false
    }
}

//MARK: TextView
extension RetrospectiveWriteTVC {
    private func setTextViews() {
        setGoodTextView()
        setBadTextView()
        setNextTextView()
    }
    
    private func setGoodTextView() {
        self.addSubview(goodTextView)
        
        goodTextView.leadingAnchor.constraint(equalTo: goodViewButton.leadingAnchor, constant: 16).isActive = true
        goodTextView.trailingAnchor.constraint(equalTo: goodViewButton.trailingAnchor, constant: -16).isActive = true
        goodTextView.topAnchor.constraint(equalTo: goodViewButton.topAnchor, constant: 16).isActive = true
        goodTextView.bottomAnchor.constraint(equalTo: goodViewButton.bottomAnchor, constant: -16).isActive = true
        
        goodTextView.font = .myRegularSystemFont(ofSize: 16)
        goodTextView.text = cellPlaceholders[0]
        goodTextView.textColor = .mainGray
        
        goodTextView.layer.cornerRadius = 12
        goodTextView.backgroundColor = UIColor.clear
        goodTextView.autocapitalizationType = .none
        goodTextView.autocorrectionType = .no
        goodTextView.smartDashesType = .no
        goodTextView.smartInsertDeleteType = .no
        goodTextView.spellCheckingType = .no
        goodTextView.isUserInteractionEnabled = false
        goodTextView.isEditable = false
    }
    
    private func setBadTextView() {
        self.addSubview(badTextView)
        
        badTextView.leadingAnchor.constraint(equalTo: badViewButton.leadingAnchor, constant: 16).isActive = true
        badTextView.trailingAnchor.constraint(equalTo: badViewButton.trailingAnchor, constant: -16).isActive = true
        badTextView.topAnchor.constraint(equalTo: badViewButton.topAnchor, constant: 16).isActive = true
        badTextView.bottomAnchor.constraint(equalTo: badViewButton.bottomAnchor, constant: -16).isActive = true
        
        badTextView.font = .myRegularSystemFont(ofSize: 16)
        badTextView.text = cellPlaceholders[1]
        badTextView.textColor = .mainGray
        
        badTextView.layer.cornerRadius = 12
        badTextView.backgroundColor = UIColor.clear
        badTextView.autocapitalizationType = .none
        badTextView.autocorrectionType = .no
        badTextView.smartDashesType = .no
        badTextView.smartInsertDeleteType = .no
        badTextView.spellCheckingType = .no
        badTextView.isUserInteractionEnabled = false
        badTextView.isEditable = false
        
        
    }
    
    private func setNextTextView() {
        self.addSubview(nextTextView)
        
        nextTextView.leadingAnchor.constraint(equalTo: nextViewButton.leadingAnchor, constant: 16).isActive = true
        nextTextView.trailingAnchor.constraint(equalTo: nextViewButton.trailingAnchor, constant: -16).isActive = true
        nextTextView.topAnchor.constraint(equalTo: nextViewButton.topAnchor, constant: 16).isActive = true
        nextTextView.bottomAnchor.constraint(equalTo: nextViewButton.bottomAnchor, constant: -16).isActive = true
        
        nextTextView.font = .myRegularSystemFont(ofSize: 16)
        nextTextView.text = cellPlaceholders[2]
        nextTextView.textColor = .mainGray
        
        nextTextView.layer.cornerRadius = 12
        nextTextView.backgroundColor = UIColor.clear
        nextTextView.autocapitalizationType = .none
        nextTextView.autocorrectionType = .no
        nextTextView.smartDashesType = .no
        nextTextView.smartInsertDeleteType = .no
        nextTextView.spellCheckingType = .no
        nextTextView.isUserInteractionEnabled = false
        nextTextView.isEditable = false
    }
}
