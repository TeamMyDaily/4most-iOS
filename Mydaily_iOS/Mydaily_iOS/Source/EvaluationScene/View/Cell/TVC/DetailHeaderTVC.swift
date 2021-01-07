//
//  DetailHeaderTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/03.
//

import UIKit

class DetailHeaderTVC: UITableViewCell {
    static let identifier = "DetailHeaderTVC"

    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DetailHeaderTVC {
    private func setLabel() {
        keywordLabel.font = .boldSystemFont(ofSize: 32)
        weekLabel.font = .systemFont(ofSize: 12)
    }
}
