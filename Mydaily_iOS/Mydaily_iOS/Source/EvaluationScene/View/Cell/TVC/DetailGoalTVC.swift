//
//  DetailGoalTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/03.
//

import UIKit

class DetailGoalTVC: UITableViewCell {
    static let identifier = "DetailGoalTVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var achieveLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DetailGoalTVC {
    private func setLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.text = "목표"
        achieveLabel.font = .systemFont(ofSize: 12)
        achieveLabel.layer.cornerRadius = 5
        achieveLabel.layer.masksToBounds = true
        achieveLabel.clipsToBounds = true
        goalLabel.font = .systemFont(ofSize: 12)
    }
}
