//
//  EvaluationHeaderTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/01.
//

import UIKit

class EvaluationHeaderTVC: UITableViewCell {
    static let identifier = "EvaluationHeaderTVC"
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: UI
extension EvaluationHeaderTVC {
    private func setLabel() {
        questionLabel.text = "이번 주 키워드와 얼마나 가까워졌나요?"
        questionLabel.font = .myBlackSystemFont(ofSize: 25)
        questionLabel.textColor = .mainBlack
    }
}
