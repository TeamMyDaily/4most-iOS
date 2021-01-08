//
//  EvaluationDetailVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/02.
//

import UIKit

class EvaluationDetailVC: UIViewController {
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var keywordDetailTableView: UITableView!
    
    var listCount = 0
    
    let originalColor: UIColor = UIColor.init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    let mainColor: UIColor = UIColor.init(red: 236/255, green: 104/255, blue: 74/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTabBar()
        setTableViewDelegate()
    }
    
    @IBAction func touchUpBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
    }
    
}

extension EvaluationDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTVC.identifier) as? DetailHeaderTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGoalTVC.identifier) as? DetailGoalTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
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
            return 104
        } else if indexPath.section == 1 {
            return 75
        } else if indexPath.section == 2 {
            return 63
        }
        var calculateHeight: CGFloat = 0
        if listCount % 2 == 0 {
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

extension EvaluationDetailVC {
    private func setNavigationBar() {
        navigationTitleLabel.text = "회고"
        navigationTitleLabel.font = .boldSystemFont(ofSize: 21)
    }
    
    private func setTabBar() {
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setTableViewDelegate() {
        keywordDetailTableView.delegate = self
        keywordDetailTableView.dataSource = self
        keywordDetailTableView.rowHeight = UITableView.automaticDimension
        keywordDetailTableView.estimatedRowHeight = 100
        keywordDetailTableView.separatorColor = .clear
    }
}
