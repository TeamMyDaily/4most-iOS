//
//  evaluationTabCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/01.
//

import UIKit

class EvaluationTabCVC: UICollectionViewCell {
    static let identifier = "EvaluationTabCVC"
    
    @IBOutlet weak var keywordTableView: UITableView!
    
    var keywords = ["아웃풋", "회고", "열정", nil]
    var goals = ["블로그에 1개 이상 퍼블리싱 하기", "진지한 글쓰기", "리얼 유노윤호 되어보기", nil]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableViewDelegate()
        setTableViewSeparator()
    }
}

extension EvaluationTabCVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EvaluationHeaderTVC.identifier) as? EvaluationHeaderTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EvaluationKeywordTVC.identifier) as? EvaluationKeywordTVC else {
            return UITableViewCell()
        }
        cell.setDataToLabel(keyword: keywords[indexPath.item] ?? "", goal: goals[indexPath.item] ?? "", index: indexPath.item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 144
        }
        return 96
    }
}

extension EvaluationTabCVC: UITableViewDelegate {}

extension EvaluationTabCVC {
    private func setTableViewSeparator() {
        keywordTableView.separatorStyle = .none
    }
    
    private func setTableViewDelegate() {
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
    }
}
