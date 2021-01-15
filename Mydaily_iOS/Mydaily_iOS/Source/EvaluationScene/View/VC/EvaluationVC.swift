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
    @IBOutlet weak var reportTabButton: UIButton!
    @IBOutlet weak var retrospectiveTabButton: UIButton!
    @IBOutlet weak var nextWeekButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var reportTabBar: UIView!
    @IBOutlet weak var retrospectiveTabBar: UIView!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    lazy var currentWeekButton: UIButton = {
        let currentWeekButton = UIButton()
        currentWeekButton.translatesAutoresizingMaskIntoConstraints = false
        currentWeekButton.backgroundColor = UIColor.mainBlack.withAlphaComponent(0.45)
        return currentWeekButton
    }()
    
    lazy var currentWeekImage: UIImageView = {
        let currentWeekImage = UIImageView()
        currentWeekImage.translatesAutoresizingMaskIntoConstraints = false
        return currentWeekImage
    }()
    
    var date = Date()
    var dateFormatter = DateFormatter()
    var dateValue = 0
    var weekText: String?
    
    override func viewWillAppear(_ animated: Bool) {
        keywordCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setReportNotification()
        setRetrospectiveNotification()
        setNavigationBar()
        setTabBar()
        setWeek()
        setLabel()
        setButtons()
        setCollectionViewDelegate()
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
            cell.weekText = weekText
            cell.collectionView = keywordCollectionView
            cell.delegate = self
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RetrospectiveTabCVC.identifier, for: indexPath) as? RetrospectiveTabCVC else {
            return UICollectionViewCell()
        }
        cell.collectionView = keywordCollectionView
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

//MARK: Action
extension EvaluationVC {
    @IBAction func touchUpReportTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in IndexPath(item: 0, section: 0)}),keywordCollectionView.cellForItem(at: indexPath) != nil else { return }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        changeButtonState(enableButton: reportTabButton, disableButton: retrospectiveTabButton, enableTabBar: reportTabBar, unableTabBar: retrospectiveTabBar)
    }
    
    @IBAction func touchUpRetrospectiveTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in IndexPath(item: 0, section: 1)}), keywordCollectionView.cellForItem(at: indexPath) != nil else { return }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        changeButtonState(enableButton: retrospectiveTabButton, disableButton: reportTabButton, enableTabBar: retrospectiveTabBar, unableTabBar: reportTabBar)
    }
    
    @IBAction func touchUpLastWeek(_ sender: Any) {
        if dateValue <= 1 {
            nextWeekButton.isEnabled = true
        }
        dateValue -= 1
        self.date = Calendar.current.date(byAdding: .day, value: -7, to: date)!
        calculateDate()
        NotificationCenter.default.post(name: Notification.Name("LastWeek"), object: nil)
    }
    
    @IBAction func touchUpNextWeek(_ sender: Any) {
        if dateValue >= 1 {
            nextWeekButton.isEnabled = false
        } else {
            nextWeekButton.isEnabled = true
            dateValue += 1
            self.date = Calendar.current.date(byAdding: .day, value: 7, to: date)!
            calculateDate()
        }
        NotificationCenter.default.post(name: Notification.Name("NextWeek"), object: nil)
    }
}

//MARK: UI
extension EvaluationVC {
    private func setNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setTabBar() {
        reportTabBar.tintColor = .mainOrange
        
        retrospectiveTabBar.tintColor = .mainOrange
        retrospectiveTabBar.isHidden = true
    }
    
    private func setLabel() {
        weekLabel.font = .myBoldSystemFont(ofSize: 12)
        weekLabel.textAlignment = .center
        
        titleLabel.font = .myBoldSystemFont(ofSize: 20)
        titleLabel.text = "회고"
        titleLabel.textColor = .mainBlack
    }
    
    private func setButtons() {
        setMenuTabButton()
        setCurrentButton()
        buttonAddTarget()
    }
    
    private func setMenuTabButton() {
        reportTabButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        reportTabButton.setTitle("리포트", for: .normal)
        reportTabButton.setTitleColor(.mainOrange, for: .normal)
        
        retrospectiveTabButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        retrospectiveTabButton.setTitle("회고", for: .normal)
        retrospectiveTabButton.setTitleColor(.mainGray, for: .normal)
    }
    
    private func setCurrentButton() {
        view.addSubview(currentWeekButton)
        
        currentWeekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentWeekButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        currentWeekButton.widthAnchor.constraint(equalToConstant: 81).isActive = true
        currentWeekButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        currentWeekButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        currentWeekButton.setTitle("이번주   ", for: .normal)
        currentWeekButton.titleLabel?.textColor = .white
        currentWeekButton.titleLabel?.textAlignment = .left
        currentWeekButton.layer.cornerRadius = 15
        currentWeekButton.layer.masksToBounds = true
        currentWeekButton.isHidden = true
        
        setCurrentImage()
    }
    
    private func setCurrentImage() {
        currentWeekButton.addSubview(currentWeekImage)
        currentWeekImage.image = UIImage(named: "btnChevronRightW")
        currentWeekImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        currentWeekImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        currentWeekImage.centerYAnchor.constraint(equalTo: currentWeekButton.centerYAnchor).isActive = true
        currentWeekImage.trailingAnchor.constraint(equalTo: currentWeekButton.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setCollectionViewDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
}

//MARK: Notification
extension EvaluationVC {
    private func setRetrospectiveNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("reloadRetrospective"), object: nil)
    }
    
    private func setReportNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("reloadReport"), object: nil)
    }
}

//MARK: Button
extension EvaluationVC {
    private func changeButtonState(enableButton: UIButton, disableButton: UIButton, enableTabBar: UIView, unableTabBar: UIView) {
        enableButton.setTitleColor(.mainOrange, for: .normal)
        disableButton.setTitleColor(.mainGray, for: .normal)
        enableTabBar.isHidden = false
        unableTabBar.isHidden = true
    }
    
    private func buttonAddTarget() {
        currentWeekButton.addTarget(self, action: #selector(backToCurrentWeek), for: .touchUpInside)
    }
    
    @objc func backToCurrentWeek() {
        setWeek()
        currentWeekButton.isHidden = true
        setRetrospectiveNotification()
        setReportNotification()
        keywordCollectionView.reloadData()
        keywordCollectionView.reloadInputViews()
    }
}

//MARK: Date
extension EvaluationVC {
    private func setWeek() {
        dateValue = 0
        self.date = Date()
        dateFormatter.dateFormat = "yy년 MM월 W주"
        weekText = dateFormatter.string(from: date.startOfWeek!.containWeek!)
        weekLabel.text = dateFormatter.string(from: date.startOfWeek!.containWeek!)
        weekLabel.textColor = .mainOrange
        nextWeekButton.isEnabled = false
    }
    
    private func calculateDate() {
        dateFormatter.dateFormat = "yy년 MM월 W주"
        weekText = dateFormatter.string(from: date.startOfWeek!.containWeek!)
        weekLabel.text = dateFormatter.string(from: date.startOfWeek!.containWeek!)
        
        if dateValue == 0 {
            nextWeekButton.isEnabled = false
            currentWeekButton.isHidden = true
            weekLabel.textColor = .mainOrange
        } else {
            currentWeekButton.isHidden = false
            weekLabel.textColor = .mainBlack
        }
    }
}

//MARK: Delegate
extension EvaluationVC: TableViewInsideCollectionViewDelegate {
    func cellTapedEvaluation(dvc: EvaluationDetailVC) {
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func cellTapedRetrospective(dvc: RetrospectiveWriteVC) {
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
