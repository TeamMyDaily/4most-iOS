//
//  EvaluationVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class EvaluationVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var evaluationTabButton: UIButton!
    @IBOutlet weak var retrospectiveTabButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var evaluationTabBar: UIView!
    @IBOutlet weak var retrospectiveTabBar: UIView!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet weak var afterWeekButton: UIButton!
    
    lazy var currentWeekButton: UIButton = {
        let currentWeekButton = UIButton()
        currentWeekButton.translatesAutoresizingMaskIntoConstraints = false
        currentWeekButton.backgroundColor = UIColor.mainBlack.withAlphaComponent(0.45)
        return currentWeekButton
    }()
    
    lazy var modifyButton: UIButton = {
        let modifyButton = UIButton()
        modifyButton.translatesAutoresizingMaskIntoConstraints = false
        return modifyButton
    }()
    
    var calendar = Calendar.current
    var dateFormatter = DateFormatter()
    var checkDateFormatter = DateFormatter()
    var dateValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTabBar()
        setWeekLabel()
        setMenuTabButton()
        setCollectionViewDelegate()
        setCurrentButton()
        setModifyButton()
        setAfterWeekButton()
    }
    
    @IBAction func touchUpEvaluationTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in
                IndexPath(item: 0, section: 0)
            }), keywordCollectionView.cellForItem(at: indexPath) != nil else {
                return
        }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        setButtonState(enableButton: evaluationTabButton, disableButton: retrospectiveTabButton, enableTabBar: evaluationTabBar, unableTabBar: retrospectiveTabBar)
        
        modifyButton.isHidden = true
    }
    
    @IBAction func touchUpRetrospectiveTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in
                IndexPath(item: 0, section: 1)
            }), keywordCollectionView.cellForItem(at: indexPath) != nil else {
                return
        }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        setButtonState(enableButton: retrospectiveTabButton, disableButton: evaluationTabButton, enableTabBar: retrospectiveTabBar, unableTabBar: evaluationTabBar)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "retrospectiveTab"), object: modifyButton)
    }
    
    @IBAction func touchUpBeforeWeek(_ sender: Any) {
        if dateValue <= 0 {
            afterWeekButton.isEnabled = true
        }
        dateValue -= 1
        guard let todayDate = calendar.date(byAdding: .weekOfMonth, value: dateValue, to: Date()) else {return}
        guard let currentDate = calendar.date(byAdding: .weekOfMonth, value: 0, to: Date()) else {return}
        let today = "\(todayDate)"
        let current = "\(currentDate)"
        dateFormatter.dateFormat = "yy년 MM월 W주"
        weekLabel.text = dateFormatter.string(from: todayDate)
        weekLabel.textColor = .mainBlack
        if today != current {
            currentWeekButton.isHidden = false
        } else {
            currentWeekButton.isHidden = true
            weekLabel.textColor = .mainOrange
        }
        
        if dateValue == 0 {
            afterWeekButton.isEnabled = false
        }
        
        NotificationCenter.default.post(name: Notification.Name("BeforeWeek"), object: nil)
    }
    
    @IBAction func touchUpAfterWeek(_ sender: Any) {
        if dateValue >= 0 {
            afterWeekButton.isEnabled = false
        } else {
            afterWeekButton.isEnabled = true
            dateValue += 1
            guard let todayDate = calendar.date(byAdding: .weekOfMonth, value: dateValue, to: Date()) else {return}
            guard let currentDate = calendar.date(byAdding: .weekOfMonth, value: 0, to: Date()) else {return}
            let today = "\(todayDate)"
            let current = "\(currentDate)"
            dateFormatter.dateFormat = "yy년 MM월 W주"
            weekLabel.text = dateFormatter.string(from: todayDate)
            weekLabel.textColor = .mainBlack
            
            if today != current {
                currentWeekButton.isHidden = false
            } else {
                currentWeekButton.isHidden = true
                weekLabel.textColor = .mainOrange
            }
            
            if dateValue == 0 {
                afterWeekButton.isEnabled = false
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name("AfterWeek"), object: nil)
    }
}

extension EvaluationVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvaluationTabCVC.identifier, for: indexPath) as? EvaluationTabCVC else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RetrospectiveTabCVC.identifier, for: indexPath) as? RetrospectiveTabCVC else {
            return UICollectionViewCell()
        }
        cell.buttonDelegate = self
        cell.delegate = self
        return cell
    }
}

extension EvaluationVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension EvaluationVC {
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setTabBar() {
        evaluationTabBar.tintColor = .mainOrange
        retrospectiveTabBar.tintColor = .mainOrange
    }
    
    private func setWeekLabel() {
        dateValue = 0
        let todayDate = Calendar.current.date(byAdding: .weekOfMonth, value: dateValue, to: Date())!
        dateFormatter.dateFormat = "yy년 MM월 w주"
        dateFormatter.locale = Locale(identifier: "ko")
        weekLabel.text = dateFormatter.string(from: todayDate)
        
        weekLabel.font = .myBoldSystemFont(ofSize: 12)
        weekLabel.textAlignment = .center
        weekLabel.textColor = .mainOrange
        
        titleLabel.font = .myBoldSystemFont(ofSize: 20)
        titleLabel.textColor = .mainBlack
    }
    
    private func setAfterWeekButton() {
        afterWeekButton.isEnabled = false
    }
    
    private func setMenuTabButton() {
        evaluationTabButton.setTitleColor(.mainOrange, for: .normal)
        evaluationTabButton.setTitle("리포트", for: .normal)
        evaluationTabButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        
        retrospectiveTabButton.setTitleColor(.mainGray, for: .normal)
        retrospectiveTabButton.setTitle("회고", for: .normal)
        retrospectiveTabButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        
        retrospectiveTabBar.isHidden = true
    }
    
    private func setCurrentButton() {
        view.addSubview(currentWeekButton)
        currentWeekButton.addTarget(self, action: #selector(backToCurrentWeek), for: .touchUpInside)
        currentWeekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentWeekButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        currentWeekButton.widthAnchor.constraint(equalToConstant: 81).isActive = true
        currentWeekButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        currentWeekButton.setTitle("이번주", for: .normal)
        currentWeekButton.titleLabel?.textAlignment = .left
        currentWeekButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        currentWeekButton.titleLabel?.textColor = .white
        currentWeekButton.layer.cornerRadius = 15
        currentWeekButton.layer.masksToBounds = true
        currentWeekButton.isHidden = true
    }
    
    private func setButtonState(enableButton: UIButton, disableButton: UIButton, enableTabBar: UIView, unableTabBar: UIView) {
        enableButton.setTitleColor(.mainOrange, for: .normal)
        disableButton.setTitleColor(.mainGray, for: .normal)
        enableTabBar.isHidden = false
        unableTabBar.isHidden = true
    }
    
    private func setModifyButton() {
        view.addSubview(modifyButton)
        modifyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        modifyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        modifyButton.setTitle("수정", for: .normal)
        modifyButton.setTitleColor(.mainBlue, for: .normal)
        modifyButton.titleLabel?.font = .myRegularSystemFont(ofSize: 16)
        modifyButton.isHidden = true
        modifyButton.addTarget(self, action: #selector(touchUpModify), for: .touchUpInside)
    }
    
    private func setCollectionViewDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    @objc func backToCurrentWeek() {
        setWeekLabel()
        currentWeekButton.isHidden = true
    }
    
    @objc func touchUpModify() {
        modifyButton.isHidden = true
        NotificationCenter.default.post(name: Notification.Name("modifyButton"), object: nil)
    }
}

extension EvaluationVC: TableViewInsideCollectionViewDelegate {
    func cellTapedEvaluation(dvc: EvaluationDetailVC) {
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func cellTapedRetrospective(dvc: RetrospectiveWriteVC) {
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension EvaluationVC: ChangeModifyButtonDelegate {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "다음에하기", style: .default)
        let okAction = UIAlertAction(title: "재설정하기", style: .default)
        noAction.setValue(UIColor.mainGray, forKey: "titleTextColor")
        okAction.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        alert.addAction(noAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func changeModifyButton(isActive: Bool) {
        modifyButton.isHidden = isActive
    }
}
