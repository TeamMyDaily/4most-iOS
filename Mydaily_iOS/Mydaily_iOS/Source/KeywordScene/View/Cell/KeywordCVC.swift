//
//  KeywordCVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2020/12/31.
//

import UIKit

class KeywordCVC: UICollectionViewCell {
    static let identifier = "KeywordCVC"
    @IBOutlet var keywordButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setKeywordButton(text: String){
        print(text)
        keywordButton.setTitle(text, for: .normal)
        keywordButton.layer.cornerRadius = 15
    }
    
    func getButton() -> UIButton{
        return keywordButton
    }
    
}
