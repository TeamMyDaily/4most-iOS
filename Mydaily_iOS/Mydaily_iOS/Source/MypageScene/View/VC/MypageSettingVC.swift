//
//  MypageSettingVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/08.
//

import UIKit

class MypageSettingVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
    }
}
//
//extension MypageSettingVC: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section ==  0 {
//            return 3
//        } else if section == 1 {
//            return 5
//        }
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingSecurityTVC.identifier) as? SettingSecurityTVC else {
//                return UITableViewCell()
//            }
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "계정 보안"
//        } else if section == 1 {
//            return "약관 및 정책"
//        }
//        return ""
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.contentView.backgroundColor = .white
//            headerView.backgroundView?.backgroundColor = .clear
//            headerView.textLabel?.textColor = .mainGray
//            headerView.textLabel?.font = .myRegularSystemFont(ofSize: 12)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 34
//    }
//}

extension MypageSettingVC: UITableViewDelegate {}

extension MypageSettingVC {
    private func setLabel() {
        nameLabel.font = .myBlackSystemFont(ofSize: 25)
        nameLabel.textColor = .mainBlack
        nameLabel.text = "엄석준님"
        
        guideLabel.font = .myRegularSystemFont(ofSize: 12)
        guideLabel.textColor = .mainGray
        guideLabel.text = "안전한 계정 이용을 위해 비밀번호는 주기적으로 변경해 주세요."
    }
    
    private func setTableViewDelegate() {
        settingTableView.delegate = self
        //settingTableView.dataSource = self
    }
}
