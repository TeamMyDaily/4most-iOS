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
	
	
	var delegate: ThreePartCellDelegate?

	var isExpanded: Bool = false
	
	@IBAction func btnMoreTapped(_ sender: Any) {
		
		if sender is UIButton {
			isExpanded = !isExpanded
			
			sizingLabel.numberOfLines = isExpanded ? 0 : 1
            labelBody.textColor = isExpanded ? UIColor.black : UIColor.white
			buttonMore.setTitle(isExpanded ? "Read less..." : "Read more...", for: .normal)
			
            delegate?.moreTapped(cell: self)

		}
		
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
        labelNum.text = "01"
        labelNum.font = .boldSystemFont(ofSize: 62)
        labelTitle.font = .boldSystemFont(ofSize: 28)
        labelSubTitle.font = .systemFont(ofSize: 12)
//        
//        let attrString = NSMutableAttributedString(string: labelBody.text!)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 10
//        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
//        labelBody.attributedText = attrString
    }
}
