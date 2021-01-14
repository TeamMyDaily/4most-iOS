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
        setViewLayer()
        setLabel()
        setBar()
    }
}

//MARK: UI
extension DetailRecordCVC {
    func setLabelText(content: String, date: String, satisfaction: Int) {
        contentLabel.text = content
        satisfactionLabel.text = "테스크 만족도: \(satisfaction)점"
        dateLabel.text = date
    }
    
    private func setViewLayer() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.mainLightOrange.cgColor
        layer.borderWidth = 1
    }
    
    private func setLabel() {
        contentLabel.font = .myBoldSystemFont(ofSize: 16)
        contentLabel.textColor = .mainBlack
        contentLabel.preferredMaxLayoutWidth = self.frame.size.width - 16 - 30
        contentLabel.contentMode = .scaleToFill
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.sizeToFit()
        
        dateLabel.font = .myRegularSystemFont(ofSize: 12)
        dateLabel.textColor = .mainGray
        
        satisfactionLabel.font = .myRegularSystemFont(ofSize: 12)
        satisfactionLabel.textColor = .mainBlack
    }
    
    private func setBar() {
        contentBar.layer.cornerRadius = 4
        contentBar.tintColor = .mainPaleOrange
    }
}
