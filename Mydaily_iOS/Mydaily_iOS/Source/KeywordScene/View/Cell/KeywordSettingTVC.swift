//
//  KeywordSettingTVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/01.
//

import UIKit

protocol SelectKeywordDelegate {
    func addSelectedKeyword(_ cell: KeywordSettingTVC, selectedText: String) -> Bool
   
    func cancelSelectedKeyword(_ cell: KeywordSettingTVC, selectedText: String)
}

class KeywordSettingTVC: UITableViewCell {

    static let identifier = "KeywordSettingTVC"
    @IBOutlet var keywordButtonList: [UIButton]!
    var cellDelegate: SelectKeywordDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0..<keywordButtonList.count{
            keywordButtonList[i].titleLabel!.font = UIFont.myMediumSystemFont(ofSize: 16)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setKeywordButton(text: [String]){
        for i in 0..<text.count{
            keywordButtonList[i].setTitle(text[i], for: .normal)
            keywordButtonList[i].layer.cornerRadius = 15
        }
    }
    
    @IBAction func touchUpButton(_ sender: UIButton) {
        let labelText = sender.titleLabel?.text ?? ""
        
        if sender.backgroundColor != UIColor.mainOrange {
            let check = cellDelegate?.addSelectedKeyword(self, selectedText: labelText) ?? false
            if check {
                sender.backgroundColor = UIColor.mainOrange
            }
            
        } else{
            sender.backgroundColor = UIColor.mainGray
            cellDelegate?.cancelSelectedKeyword(self, selectedText: labelText)
        }
    }
    
}
