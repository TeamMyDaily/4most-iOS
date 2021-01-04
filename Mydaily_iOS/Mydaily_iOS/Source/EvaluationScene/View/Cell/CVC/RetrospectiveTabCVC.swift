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
    }
}

extension RetrospectiveTabCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RetrospectiveWriteTVC.identifier) as? RetrospectiveWriteTVC else {
            return UITableViewCell()
        }
//        cell.selectionStyle = .none
        cell.setLabelData(title: cellTitles[indexPath.row], placeholder: cellPlaceholders[indexPath.row])
        return cell
    }
}

extension RetrospectiveTabCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.size.height - 150 - 104)/3
    }
}

extension RetrospectiveTabCVC {
    private func setTableView() {
        retrospectiveTableView.delegate = self
        retrospectiveTableView.dataSource = self
    }
}

