//
//  KeywordTVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/11.
//

import UIKit

class RecordKeywordTVC: UITableViewCell {
    static let identifier = "RecordKeywordTVC"
    @IBOutlet var keywordLabel: UILabel!
    @IBOutlet var rankingNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setContent(rank: Int, keyword: String){
        rankingNumber.text = "\(rank)"
        keywordLabel.text = keyword
    }
    
}
