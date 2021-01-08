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
    @IBOutlet weak var rightForwardButton: UIButton!
    
    var isAchieve = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        setButton()
        setAchieve()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DetailGoalTVC {
    private func setLabel() {
        titleLabel.font = .myBoldSystemFont(ofSize: 18)
        titleLabel.textColor = .mainBlack
        titleLabel.text = "목표"
        goalLabel.font = .myRegularSystemFont(ofSize: 12)
        goalLabel.textColor = .mainBlack
        goalLabel.text = "블로그에 1개이상 퍼블리싱 하기"
    }
    
    private func setButton() {
        if isAchieve {
            achieveButton.setTitle("달성", for: .normal)
            achieveButton.setTitleColor(.mainOrange, for: .normal)
            achieveButton.backgroundColor = .white
            achieveButton.titleLabel?.font = .myRegularSystemFont(ofSize: 12)
            achieveButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
            achieveButton.layer.cornerRadius = 10
            achieveButton.layer.masksToBounds = true
            achieveButton.setContentHuggingPriority(.required, for: .horizontal)
            achieveButton.isUserInteractionEnabled = false
        } else {
            achieveButton.setTitle("미달성", for: .normal)
            achieveButton.setTitleColor(.white, for: .normal)
            achieveButton.tintColor = .mainLightGray
            achieveButton.titleLabel?.font = .myRegularSystemFont(ofSize: 12)
            achieveButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
            achieveButton.layer.cornerRadius = 10
            achieveButton.layer.masksToBounds = true
            achieveButton.setContentHuggingPriority(.required, for: .horizontal)
            achieveButton.isUserInteractionEnabled = false
        }
    }
    
    private func setAchieve() {
        if isAchieve {
            self.backgroundColor = .mainOrange
            goalLabel.textColor = .white
            titleLabel.textColor = .white
            rightForwardButton.tintColor = .white
        } else {
            self.backgroundColor = .white
            goalLabel.textColor = .mainBlack
            titleLabel.textColor = .mainBlack
            rightForwardButton.tintColor = .mainGray
        }
    }
}
