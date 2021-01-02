//
//  KeywordTableViewCell.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/01.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {

    static let identifier = "KeywordTableViewCell"
    @IBOutlet var keywordButtonList: [UIButton]!
    

    let originButtonColor: UIColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setKeywordButton(text: [String]){
        for i in 0..<text.count{
            print("i = \(i)")
            if i == 4{
                keywordButtonList[i].isHidden = false
            }
            keywordButtonList[i].setTitle(text[i], for: .normal)
            keywordButtonList[i].layer.cornerRadius = 15
        }
    }
    
    
    
    @IBAction func touchUpButton(_ sender: UIButton) {
        let labelText = sender.titleLabel?.text ?? ""
        
        if sender.backgroundColor != .orange {
            sender.backgroundColor = .orange
            KeywordSettingVC.addSelectedKeyword(text:labelText)
            
        } else{
            sender.backgroundColor = originButtonColor
            KeywordSettingVC.removeSelectedKeyword(text: labelText)
        }
    }
    
}
