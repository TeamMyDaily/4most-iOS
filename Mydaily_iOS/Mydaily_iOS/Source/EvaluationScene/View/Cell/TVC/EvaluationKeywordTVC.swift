//
//  EvaluationKeywordTVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/01.
//

import UIKit

class EvaluationKeywordTVC: UITableViewCell {
    static let identifier = "EvaluationKeywordTVC"

    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var addKeywordImage: UIImageView!
    
    let mainColor: UIColor = UIColor.init(red: 236/255, green: 104/255, blue: 74/255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setKeywordView()
        setLabel()
        setSlider()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func moveSlider(_ sender: Any) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        let valueNumber: Float = rateSlider.value
        let formatterNumber = numberFormatter.string(from: NSNumber(value: valueNumber))
        rateLabel.text = "\(formatterNumber ?? " ")"
    }
}

extension EvaluationKeywordTVC {
    func setDataToLabel(keyword: String, goal: String, index: Int) {
        if keyword != "" {
            keywordLabel.text = keyword
            goalLabel.text = goal
        } else if keyword == "" && index < 3 {
            keywordLabel.isHidden = true
            rateLabel.isHidden = true
            goalLabel.isHidden = true
            rateSlider.isHidden = true
            outlineView.isHidden = true
        } else if keyword == "" && index == 3 {
            keywordLabel.isHidden = true
            rateLabel.isHidden = true
            goalLabel.isHidden = true
            rateSlider.isHidden = true
            addKeywordImage.isHidden = false
        }
    }
    
    private func setKeywordView() {
        outlineView.layer.cornerRadius = 10
        outlineView.layer.borderWidth = 1
        outlineView.layer.borderColor = CGColor.init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        addKeywordImage.isHidden = true
    }
    
    private func setLabel() {
        keywordLabel.font = .boldSystemFont(ofSize: 21)
        rateLabel.font = .systemFont(ofSize: 32, weight: .medium)
        rateLabel.textColor = mainColor
        goalLabel.font = .systemFont(ofSize: 12, weight: .medium)
        goalLabel.textColor = UIColor.init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    }
}

extension EvaluationKeywordTVC {
    private func setSlider() {
        rateSlider.value = 3
        rateSlider.setThumbImage(self.rateSliderThumbImage(with: self.rateSlider.value), for: UIControl.State.normal)
        rateSlider.setThumbImage(self.rateSliderThumbImage(with: self.rateSlider.value), for: UIControl.State.selected)
        setSliderColor()
    }
    
    private func rateSliderThumbImage(with progress: Float) -> UIImage {
        let layer = CALayer()
        layer.backgroundColor = mainColor.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        layer.cornerRadius = 4
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    private func setSliderColor() {
        let gradientLayer = CAGradientLayer()
        let frame = CGRect.init(x: 0, y: 0, width: rateSlider.frame.size.width, height: 6)
        let secondColor = UIColor.init(red: 245/255, green: 149/255, blue: 128/255, alpha: 1)
        let thirdColor = UIColor.init(red: 254/255, green: 198/255, blue: 186/255, alpha: 1)
        
        gradientLayer.cornerRadius = 2.5
        gradientLayer.frame = frame
        gradientLayer.colors = [mainColor.cgColor, secondColor.cgColor, thirdColor.cgColor,  UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.isOpaque, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            image.resizableImage(withCapInsets: UIEdgeInsets.zero)
            rateSlider.setMinimumTrackImage(image, for: .normal)
        }
    }
}
