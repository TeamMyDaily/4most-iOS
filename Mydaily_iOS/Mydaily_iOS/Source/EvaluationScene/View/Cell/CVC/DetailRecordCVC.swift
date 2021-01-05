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
    }
    
    private func setConfigure() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemRed.cgColor
        layer.borderWidth = 1
        contentBar.layer.cornerRadius = 4
        
        contentLabel.preferredMaxLayoutWidth = self.frame.size.width - 16 - 30
        contentLabel.contentMode = .scaleToFill
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.sizeToFit()
        
        contentLabel.font = .boldSystemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 12)
        satisfactionLabel.font = .systemFont(ofSize: 12)
    }
}
