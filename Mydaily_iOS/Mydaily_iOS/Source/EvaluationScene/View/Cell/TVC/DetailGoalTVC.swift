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
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var achieveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        setButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DetailGoalTVC {
    private func setLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.text = "목표"
        goalLabel.font = .systemFont(ofSize: 12)
    }
    
    private func setButton() {
        achieveButton.setTitle("미달성", for: .normal)
        achieveButton.titleLabel?.font = .systemFont(ofSize: 12)
        achieveButton.contentEdgeInsets = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        achieveButton.layer.cornerRadius = 10
        achieveButton.layer.masksToBounds = true
        achieveButton.setContentHuggingPriority(.required, for: .horizontal)
        achieveButton.isUserInteractionEnabled = false
    }
}
