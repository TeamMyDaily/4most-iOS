//
//  ContentCell.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2020/12/30.
//

import UIKit

class ContentCell: UICollectionViewCell {
    static let identifier = "ContentCell"
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    func setLabel(question: String, answer: String){
        questionLabel.numberOfLines = 0
        answerLabel.numberOfLines = 0
        questionLabel.text = question
        answerLabel.text = answer
    }
    
}
