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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setKeywordLabel(text: String){
        keywordLabel.text = text
    }
    
}
