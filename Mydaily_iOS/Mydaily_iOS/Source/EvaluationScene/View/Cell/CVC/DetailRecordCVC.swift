//
//  DetailRecordCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/03.
//

import UIKit

class DetailRecordCVC: UICollectionViewCell {
    static let identifier = "DetailRecordCVC"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentBar: UIView!
    @IBOutlet weak var satisfactionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setConfigure()
    }
}

extension DetailRecordCVC {
    func setLabelData(content: String) {
        contentLabel.text = content
        satisfactionLabel.text = "테스크 만족도: 3점"
        dateLabel.text = "2020. 12. 18"
    }
    
    private func setConfigure() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.mainLightOrange.cgColor
        layer.borderWidth = 1
        contentBar.layer.cornerRadius = 4
        contentBar.tintColor = .mainPaleOrange
        
        contentLabel.preferredMaxLayoutWidth = self.frame.size.width - 16 - 30
        contentLabel.contentMode = .scaleToFill
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.sizeToFit()
        
        contentLabel.font = .myBoldSystemFont(ofSize: 16)
        contentLabel.textColor = .mainBlack
        dateLabel.font = .myRegularSystemFont(ofSize: 12)
        dateLabel.textColor = .mainGray
        satisfactionLabel.font = .myRegularSystemFont(ofSize: 12)
        satisfactionLabel.textColor = .mainBlack
    }
}
