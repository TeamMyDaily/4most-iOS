//
//  UserKeywordTVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/11.
//

import UIKit

class UserKeywordTVC: UITableViewCell {
    static let identifier = "UserKeywordTVC"
    
    @IBOutlet var fixClipImageView: UIImageView!
    @IBOutlet var keywordLabel: UILabel!
    @IBOutlet var menuImageView: UIImageView!
    var isSelectedKeyword = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setContent(selected: Bool, keyword: String){
        if selected {
            fixClipImageView.image = UIImage(systemName: "paperclip.circle.fill")
        }
        keywordLabel.text = keyword
    }
    
}
