//
//  RetrospectiveTabCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/01.
//

import UIKit

class RetrospectiveTabCVC: UICollectionViewCell {
    static let identifier = "RetrospectiveTabCVC"
    
    @IBOutlet weak var retrospectiveTableView: UITableView!
    
    var cellTitles = ["이번주의 잘 한 점", "이번주 아쉬운 점", "다음주에 임하는 마음가짐"]
    var cellPlaceholders = ["이번주, 어떤 내 모습을 칭찬 해주고 싶나요?", "한 주에 아쉬움이 남은 점이 있을까요?", "다음주에는 어떻게 지내고 싶은가요?"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableView()
//        setKeyboardGesture()
    }
}

extension RetrospectiveTabCVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RetrospectiveWriteGoodTVC.identifier) as? RetrospectiveWriteGoodTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = retrospectiveTableView
            cell.setLabelData(title: cellTitles[indexPath.section], placeholder: cellPlaceholders[indexPath.section])
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RetrospectiveWriteShameTVC.identifier) as? RetrospectiveWriteShameTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = retrospectiveTableView
            cell.setLabelData(title: cellTitles[indexPath.section], placeholder: cellPlaceholders[indexPath.section])
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RetrospectiveWritePromiseTVC.identifier) as? RetrospectiveWritePromiseTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.delegate = retrospectiveTableView
        cell.setLabelData(title: cellTitles[indexPath.section], placeholder: cellPlaceholders[indexPath.section])
        return cell
    }
}

extension RetrospectiveTabCVC: UITableViewDelegate {}

extension RetrospectiveTabCVC {
    private func setTableView() {
        retrospectiveTableView.delegate = self
        retrospectiveTableView.dataSource = self
        retrospectiveTableView.separatorColor = .clear
        retrospectiveTableView.estimatedRowHeight = (UIScreen.main.bounds.size.height - 150 - 104)/3
        retrospectiveTableView.rowHeight = UITableView.automaticDimension
    }
    
//    private func setKeyboardGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        self.addGestureRecognizer(tap)
//    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
