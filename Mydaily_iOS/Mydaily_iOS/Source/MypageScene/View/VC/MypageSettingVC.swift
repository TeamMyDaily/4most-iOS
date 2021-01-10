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
    @IBOutlet weak var securityHeaderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    
    var securityTitles: [String] = ["본인인증", "계정 비밀번호 변경"]
    var policyTitles: [String] = ["포모스트 이용약관", "개인정보 처리 방침", "서비스 이용약관", "오픈소스라이선스", "회원 탈퇴"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setTableView()
    }
}

extension MypageSettingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section ==  0 {
            return 2
        } else if section == 1 {
            return 5
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingSecurityTVC.identifier) as? SettingSecurityTVC else {
                return UITableViewCell()
            }
            cell.setLabel(title: securityTitles[indexPath.row], color: UIColor.mainBlack)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingSecurityTVC.identifier) as? SettingSecurityTVC else {
                return UITableViewCell()
            }
            if policyTitles[indexPath.row] == "회원 탈퇴" {
                cell.setLabel(title: policyTitles[indexPath.row], color: UIColor.mainGray)
            } else {
                cell.setLabel(title: policyTitles[indexPath.row], color: UIColor.mainBlack)
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingVersionTVC.identifier) as? SettingVersionTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "약관 및 정책"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 58))
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 43, width: 80, height: 13)
            label.text = "약관 및 정책"
            label.textColor = .mainGray
            label.font = .myRegularSystemFont(ofSize: 12)
            view.addSubview(label)
            
            return view
        }
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 58
        } else if section == 2 {
            return 20
        }
        return 0
    }
}

extension MypageSettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            guard let dvc = self.storyboard?.instantiateViewController(identifier: "MypageIdentityVerificationVC") as? MypageIdentityVerificationVC else {
                return
            }
            present(dvc, animated: true, completion: nil)
        } else if indexPath.section == 1 && indexPath.row == 4 {
            guard let dvc = self.storyboard?.instantiateViewController(identifier: "MypageWithdrawalVC") as? MypageWithdrawalVC else {
                return
            }
            present(dvc, animated: true, completion: nil)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            guard let dvc = self.storyboard?.instantiateViewController(identifier: "MypageChangePasswordVC") as? MypageChangePasswordVC else {
                return
            }
            present(dvc, animated: true, completion: nil)
        }
    }
}

//MARK: UI
extension MypageSettingVC {
    private func setLabel() {
        nameLabel.font = .myBlackSystemFont(ofSize: 25)
        nameLabel.text = "엄석준님"
        nameLabel.textColor = .mainBlack
        
        guideLabel.font = .myRegularSystemFont(ofSize: 12)
        guideLabel.text = "안전한 계정 이용을 위해 비밀번호는 주기적으로 변경해 주세요."
        guideLabel.textColor = .mainGray
        
        securityHeaderLabel.font = .myRegularSystemFont(ofSize: 12)
        securityHeaderLabel.text = "계정 보안"
        securityHeaderLabel.textColor = .mainGray
        
        emailLabel.font = .myRegularSystemFont(ofSize: 16)
        emailLabel.text = "이메일"
        emailLabel.textColor = .mainBlack
        
        userEmailLabel.font = .myRegularSystemFont(ofSize: 15)
        userEmailLabel.text = "tlsdbsdk05250@gmail.com"
        userEmailLabel.textColor = .mainOrange
    }
    
    private func setTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.separatorStyle = .none
    }
}
