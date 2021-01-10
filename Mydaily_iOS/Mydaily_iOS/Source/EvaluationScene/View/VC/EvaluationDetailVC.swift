//
//  EvaluationDetailVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/02.
//

import UIKit

class EvaluationDetailVC: UIViewController {
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var keywordDetailTableView: UITableView!
    
    var listCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setLabel()
    }
    
}

extension EvaluationDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGoalTVC.identifier) as? DetailGoalTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecordTVC.identifier) as? DetailRecordTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecordContentTVC.identifier) as? DetailRecordContentTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        listCount = cell.list.count
        return cell
    }
}

extension EvaluationDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 91
        } else if indexPath.section == 1 {
            return 42
        }
        
        var calculateHeight: CGFloat = 0
        if listCount == 0 {
            calculateHeight = 368
        }   else if listCount % 2 == 0 {
            calculateHeight = CGFloat(42 + listCount / 2 * 185)
        } else {
            if listCount == 1 {
                calculateHeight = 222
            }
            calculateHeight = CGFloat(42 + (listCount / 2 + 1) * 185)
        }
        return calculateHeight
    }
}

//MARK: Action
extension EvaluationDetailVC {
    @IBAction func touchUpBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UI
extension EvaluationDetailVC {
    private func setNavigationBar() {
        navigationTitleLabel.text = "회고"
        navigationTitleLabel.textColor = .mainBlack
        navigationTitleLabel.font = .myBoldSystemFont(ofSize: 20)
    }
    
    private func setTableView() {
        keywordDetailTableView.delegate = self
        keywordDetailTableView.dataSource = self
        keywordDetailTableView.rowHeight = UITableView.automaticDimension
        keywordDetailTableView.estimatedRowHeight = 100
        keywordDetailTableView.separatorColor = .clear
    }
    
    private func setLabel() {
        keywordLabel.font = .myBoldSystemFont(ofSize: 32)
        keywordLabel.text = "아웃풋"
        keywordLabel.textColor = .mainBlack
        
        weekLabel.font = .myRegularSystemFont(ofSize: 12)
        weekLabel.text = "20년 12월 3주"
        weekLabel.textColor = .mainGray
    }
}
