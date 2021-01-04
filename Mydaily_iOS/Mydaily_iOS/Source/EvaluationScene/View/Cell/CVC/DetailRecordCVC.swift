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
    
    func setConfigure(content: String) {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemRed.cgColor
        layer.borderWidth = 1
        contentBar.layer.cornerRadius = 4
        
        contentLabel.font = .boldSystemFont(ofSize: 16)
        contentLabel.text = content
        contentLabel.preferredMaxLayoutWidth = self.frame.size.width - 16 - 30
        contentLabel.contentMode = .scaleToFill
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.sizeToFit()

        dateLabel.font = .systemFont(ofSize: 12)
        satisfactionLabel.font = .systemFont(ofSize: 12)
        satisfactionLabel.text = "테스크 만족도: 3점"
    }
}
