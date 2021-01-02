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
    var goals = ["블로그에 1개 이상 퍼블리싱 하기", "진지한 글쓰기", "나는야 열정만수르 내가 그 누구보다 잘나가네 야하 나는 열정만수르", nil]
    var rates = [2.6, 4.2, 5.0, nil]
    var counts = [4, 3, 3, nil]
    
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
        cell.setData(keyword: keywords[indexPath.item] ?? "", goal: goals[indexPath.item] ?? "", index: indexPath.item, rate: rates[indexPath.item] ?? 0.0, count: counts[indexPath.item] ?? 0)
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

extension EvaluationTabCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 && indexPath.row == 1 && indexPath.row == 2 {
            if keywords[indexPath.row] != nil {
                // navigation push 
            }
        } else if indexPath.section == 1 && indexPath.row == 3 {
            if keywords[indexPath.row] != nil {
                // navigation push
            } else {
                // 키워드 + 하는 뷰로
            }
        }
    }
}

extension EvaluationTabCVC {
    private func setTableViewSeparator() {
        keywordTableView.separatorStyle = .none
    }
    
    private func setTableViewDelegate() {
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
    }
}
