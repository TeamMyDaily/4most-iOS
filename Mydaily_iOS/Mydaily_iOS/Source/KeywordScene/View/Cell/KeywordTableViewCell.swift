//
//  KeywordTableViewCell.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/01.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {

    static let identifier = "KeywordTableViewCell"
    
    @IBOutlet var KeywordButtonLIst: [UIButton]!
    
    
    @IBOutlet var keywordButton1: UIButton!
    @IBOutlet var keywordButton2: UIButton!
    @IBOutlet var keywordButton3: UIButton!
    @IBOutlet var keywordButton4: UIButton!
  
    let originButtonColor: UIColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setKeywordButton1(text: String){
        print(text)
        keywordButton1.setTitle(text, for: .normal)
        keywordButton1.layer.cornerRadius = 15
        
    }
    
    func setKeywordButton2(text: String){
        print(text)
        keywordButton2.setTitle(text, for: .normal)
        keywordButton2.layer.cornerRadius = 15
    }
    
    func setKeywordButton3(text: String){
        print(text)
        keywordButton3.setTitle(text, for: .normal)
        keywordButton3.layer.cornerRadius = 15
    }
    
    func setKeywordButton4(text: String){
        print(text)
        keywordButton4.setTitle(text, for: .normal)
        keywordButton4.layer.cornerRadius = 15
    }
    
    
   
    @IBAction func touchUpButton1(_ sender: Any) {
        let labelText = keywordButton1.titleLabel?.text ?? ""
       
        if keywordButton1.backgroundColor != .orange {
            keywordButton1.backgroundColor = .orange
            KeywordSettingVC.addSelectedKeyword(text:labelText)
            
        } else{
            keywordButton1.backgroundColor = originButtonColor
            KeywordSettingVC.removeSelectedKeyword(text: labelText)
        }
        
    }
    
    @IBAction func touchUpButton2(_ sender: Any) {
        let labelText = keywordButton2.titleLabel?.text ?? ""
        
        if keywordButton2.backgroundColor != .orange {
            keywordButton2.backgroundColor = .orange
            KeywordSettingVC.addSelectedKeyword(text:labelText)
            
        } else{
            keywordButton2.backgroundColor = originButtonColor
            KeywordSettingVC.removeSelectedKeyword(text: labelText)
        }
    }
    
    @IBAction func touchUpButton3(_ sender: Any) {
        let labelText = keywordButton3.titleLabel?.text ?? ""
        
        if keywordButton3.backgroundColor != .orange {
            keywordButton3.backgroundColor = .orange
            KeywordSettingVC.addSelectedKeyword(text:labelText)
            
        } else{
            keywordButton3.backgroundColor = originButtonColor
            KeywordSettingVC.removeSelectedKeyword(text: labelText)
        }
        
    }
    
    @IBAction func touchUpButton4(_ sender: Any) {
        let labelText = keywordButton4.titleLabel?.text ?? ""
        
        if keywordButton4.backgroundColor != .orange {
            keywordButton4.backgroundColor = .orange
            KeywordSettingVC.addSelectedKeyword(text:labelText)
        } else{
            keywordButton4.backgroundColor = originButtonColor
            KeywordSettingVC.removeSelectedKeyword(text: labelText)
        }
    }
    
}
