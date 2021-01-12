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
    
    var isAchieve = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        setButton()
        setColorWhenAchieve()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: UI
extension DetailGoalTVC {
    func setData(goal: String, isGoalCompleted: Bool) {
        goalLabel.text = goal
        isAchieve = isGoalCompleted
    }
    
    private func setLabel() {
        titleLabel.font = .myBoldSystemFont(ofSize: 18)
        titleLabel.text = "목표"
        titleLabel.textColor = .mainBlack
        
        goalLabel.font = .myRegularSystemFont(ofSize: 12)
        goalLabel.textColor = .mainBlack
    }
    
    private func setButton() {
        if isAchieve {
            achieveButton.titleLabel?.font = .myRegularSystemFont(ofSize: 12)
            achieveButton.setTitle("달성", for: .normal)
            achieveButton.setTitleColor(.mainOrange, for: .normal)
            achieveButton.backgroundColor = .white
            achieveButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
            achieveButton.setContentHuggingPriority(.required, for: .horizontal)
            achieveButton.layer.cornerRadius = 10
            achieveButton.layer.masksToBounds = true
            achieveButton.isUserInteractionEnabled = false
        } else {
            achieveButton.titleLabel?.font = .myRegularSystemFont(ofSize: 12)
            achieveButton.setTitle("미달성", for: .normal)
            achieveButton.setTitleColor(.white, for: .normal)
            achieveButton.tintColor = .mainLightGray
            achieveButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
            achieveButton.setContentHuggingPriority(.required, for: .horizontal)
            achieveButton.layer.cornerRadius = 10
            achieveButton.layer.masksToBounds = true
            achieveButton.isUserInteractionEnabled = false
        }
    }
    
    private func setColorWhenAchieve() {
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
