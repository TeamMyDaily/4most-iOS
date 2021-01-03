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
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemRed.cgColor
//        contentBar.layer.cornerRadius = 4
//
//        dateLabel.font = .systemFont(ofSize: 12)
//        contentLabel.font = .boldSystemFont(ofSize: 16)
//        contentLabel.text = content
//        contentLabel.adjustsFontSizeToFitWidth = true
//        contentLabel.sizeToFit()
//        satisfactionLabel.font = .systemFont(ofSize: 12)
    }
}
