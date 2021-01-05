//
//  RecordTVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/05.
//

import UIKit

class RecordTVC: UITableViewCell {
    static let reuseIdentifier = "RecordTVCIdentifier"
    static let nibName = "RecordTVC"
    var toggle:Bool = true
    
    @IBOutlet weak var recordCount: UILabel!
    @IBOutlet weak var keywordName: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func toggleButton(_ sender: Any) {
        if toggle {
            UIView.animate(withDuration: 0.5, animations: {
                self.detailView.frame.size.height = 150.0
            })
//            buttonImg.setImage(UIImage(named: "iconRealtimeMore"), for: .normal)
//            RankLabel.alpha = 0
//            RankItemLabel.alpha = 0
        }
        else {
//            buttonImg.setImage(UIImage(named: "iconRealtimeMore2"), for: .normal)

            UIView.animate(withDuration: 0.5, animations: {
                self.detailView.frame.size.height = 0
            })
//            RankLabel.alpha = 1
//            RankItemLabel.alpha = 1
            
        }
        toggle = !toggle
    }
    
}

extension RecordTVC {
    func setUI(){
        
    }
}
