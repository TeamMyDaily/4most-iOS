//
//  SettingSecurityTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/08.
//

import UIKit

class SettingSecurityTVC: UITableViewCell {
    static let identifier = "SettingSecurityTVC"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: UI
extension SettingSecurityTVC {
    func setLabel(title: String, color: UIColor) {
        titleLabel.font = .myRegularSystemFont(ofSize: 16)
        titleLabel.text = title
        titleLabel.textColor = color
    }
}
