//
//  UserKeywordTVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/11.
//

import UIKit

protocol menuAlertDelegate {
    func alertKeywordMenu(_ cell: UserKeywordTVC, keyword: String)
}

class UserKeywordTVC: UITableViewCell {
    static let identifier = "UserKeywordTVC"
    
    @IBOutlet var fixClipButton: UIButton!
    @IBOutlet var keywordLabel: UILabel!
    @IBOutlet var menuButton: UIButton!
    var cellDelegate: menuAlertDelegate?
    
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
            fixClipButton.setBackgroundImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        }
        keywordLabel.text = keyword
    }
    
    @IBAction func alertKeywordMenu(_ sender: UIButton){
        print("메뉴바 눌림")
        cellDelegate?.alertKeywordMenu(self, keyword: keywordLabel.text ?? "")
        
        
        
        
    }
    
    
    
}
