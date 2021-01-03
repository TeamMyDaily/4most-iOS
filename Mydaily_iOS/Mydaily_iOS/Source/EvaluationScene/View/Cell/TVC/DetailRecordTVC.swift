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
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.text = "하루 기록"
        recordCountLabel.font = .systemFont(ofSize: 12)
    }
}
