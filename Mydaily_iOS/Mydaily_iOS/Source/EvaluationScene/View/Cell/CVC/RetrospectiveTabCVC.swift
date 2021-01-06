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
    
    var delegate: TableViewInsideCollectionViewDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableView()
    }
}

extension RetrospectiveTabCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: RetrospectiveWriteTVC.identifier) as? RetrospectiveWriteTVC else {
               return UITableViewCell()
           }
           cell.delegate = self.delegate
           cell.tableView = retrospectiveTableView
           cell.selectionStyle = .none
           return cell
    }
}

extension RetrospectiveTabCVC: UITableViewDelegate {}

extension RetrospectiveTabCVC {
    private func setTableView() {
        retrospectiveTableView.delegate = self
        retrospectiveTableView.dataSource = self
        retrospectiveTableView.separatorColor = .clear
        retrospectiveTableView.rowHeight = UIScreen.main.bounds.size.height - 180
    }
}
