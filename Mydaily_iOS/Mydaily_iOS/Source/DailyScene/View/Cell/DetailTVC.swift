//
//  ThreePartDynaTableViewCell.swift
//  DynamicCellHeight
//
//  Created by Don Mag on 3/23/17.
//  Copyright © 2017 DonMag. All rights reserved.
//

import UIKit

protocol ThreePartCellDelegate {
	func moreTapped(cell: DetailTVC)
}

class DetailTVC: UITableViewCell {

    @IBOutlet weak var labelNum: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelBody: UILabel!
	@IBOutlet weak var buttonMore: UIButton!
	@IBOutlet weak var sizingLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: ThreePartCellDelegate?

    var isExpanded: Bool = false
    
    @IBAction func btnMoreTapped(_ sender: Any) {
		
		if sender is UIButton {
			isExpanded = !isExpanded
			
			sizingLabel.numberOfLines = isExpanded ? 0 : 1
            labelBody.textColor = isExpanded ? UIColor.mainLightGray3 : UIColor.white
            labelBody.font = .myRegularSystemFont(ofSize: 15)
            sizingLabel.font = .myRegularSystemFont(ofSize: 15)
			buttonMore.setTitle(isExpanded ? "Read..." : "Read...", for: .normal)
			
            delegate?.moreTapped(cell: self)
		}
	}
	
    @IBAction func addButton(_ sender: Any) {
        guard let dvc = UIStoryboard(name: "Daily", bundle: nil).instantiateViewController(withIdentifier: "DailyWriteVC") as? DailyWriteVC else {
            return
        }
        UIApplication.topViewController()?.navigationController?.pushViewController(dvc, animated: true)
//        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    public func myInit(theTitle: String, theBody: String) {
		
		isExpanded = false
		
		labelTitle.text = theTitle
		labelBody.text = theBody
		
		labelBody.numberOfLines = 0

		sizingLabel.text = theBody
		sizingLabel.numberOfLines = 1

	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailTVC {
    func setUI(){
        //서버연결시 변경
        labelNum.text = "01"
        labelNum.font = .myBoldSystemFont(ofSize: 62)
        labelTitle.font = .myBoldSystemFont(ofSize: 28)
        labelTitle.sizeToFit()
        labelTitle.textColor = UIColor.mainBlack
        labelSubTitle.text = "4개의 기록이 당신을 기다리고 있어요."
        labelSubTitle.font = .myRegularSystemFont(ofSize: 12)
        labelSubTitle.textColor = UIColor.mainGray
        
        let attributedString = NSMutableAttributedString(string: labelSubTitle.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainOrange, range: (labelSubTitle.text! as NSString).range(of:"4개의 기록"))
        labelSubTitle.attributedText = attributedString

    }
}
