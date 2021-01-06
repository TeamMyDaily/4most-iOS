//
//  KeywordPriorityTVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/05.
//

import UIKit

class KeywordPriorityTVC: UITableViewCell {
    static let identifier = "KeywordPriorityTVC"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var moveButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setKeywordLabel(text: String){
        keywordLabel.text = text
        print("-------cell--------")
        print(keywordLabel.text)
    }
    
}
