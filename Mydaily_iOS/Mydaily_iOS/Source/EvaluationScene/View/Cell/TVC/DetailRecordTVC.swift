//
//  DetailRecordTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/03.
//

import UIKit

class DetailRecordTVC: UITableViewCell {
    static let identifier = "DetailRecordTVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recordCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DetailRecordTVC {
    private func setLabel() {
        titleLabel.font = .myBoldSystemFont(ofSize: 18)
        titleLabel.textColor = .mainBlack
        titleLabel.text = "하루 기록"
        recordCountLabel.font = .myRegularSystemFont(ofSize: 12)
        recordCountLabel.text = "총 5개"
        recordCountLabel.textColor = .mainGray
    }
}
