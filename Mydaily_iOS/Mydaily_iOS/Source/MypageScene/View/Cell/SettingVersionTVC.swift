//
//  SettingVersionTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/08.
//

import UIKit

class SettingVersionTVC: UITableViewCell {
    static let identifier = "SettingVersionTVC"

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var currentVersionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: UI
extension SettingVersionTVC {
    private func setLabel() {
        versionLabel.font = .myRegularSystemFont(ofSize: 15)
        versionLabel.text = "앱 버전 정보"
        versionLabel.textColor = .mainBlack
        
        currentVersionLabel.font = .myRegularSystemFont(ofSize: 15)
        currentVersionLabel.text = "(현재버전 1.0.0)"
        currentVersionLabel.textColor = .mainGray
    }
}
