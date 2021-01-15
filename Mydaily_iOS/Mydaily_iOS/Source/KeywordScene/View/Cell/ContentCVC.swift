//
//  KeywordPopUpContentCVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2020/12/30.
//

import UIKit

class ContentCVC: UICollectionViewCell {
    static let identifier = "ContentCVC"
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionLabel.font = UIFont.myBoldSystemFont(ofSize: 18)
        questionLabel.textColor = UIColor.mainBlack
        answerLabel.font = UIFont.myMediumSystemFont(ofSize: 12)
        answerLabel.textColor = UIColor.mainGray
        // Initialization code
    }
    
    func setImage(image: UIImage){
        mainImageView.image = image
    }
    
    func setLabel(question: String, answer: String){
        questionLabel.numberOfLines = 0
        answerLabel.numberOfLines = 0
        questionLabel.text = question
        
        if answer == ""{
            answerLabel.isHidden = true
        
        }else{
            answerLabel.text = answer
        }
    }
    

}
