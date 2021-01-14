
//  DailyTVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//


import UIKit

protocol ThreePartCellDelegate {
    func moreTapped(cell: DetailTVC)
}

class DetailTVC: UITableViewCell {
    
    static let reuseIdentifier = "DetailTableViewCellIdentifier"
    static let nibName = "DetailTVC"

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
//        guard let dvc = UIStoryboard(name: "Daily", bundle: nil).instantiateViewController(withIdentifier: "DailyWriteVC") as? DailyWriteVC else {
//            return
//        }
//        UIApplication.topViewController()?.navigationController?.pushViewController(dvc, animated: true)
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
        labelNum.font = .myBoldSystemFont(ofSize: 62)
        labelTitle.font = .myBoldSystemFont(ofSize: 28)
        labelTitle.sizeToFit()
        labelTitle.textColor = UIColor.mainBlack
        labelSubTitle.font = .myRegularSystemFont(ofSize: 12)
        labelSubTitle.textColor = UIColor.mainGray
    }
}
