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
    @IBOutlet weak var totalCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setKeywordView()
        setLabel()
        setSlider()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: UI
extension EvaluationKeywordTVC {
    func setCellInsideData(keyword: String, goal: String, index: Int, rate: Double, count: Int) {
        if keyword != "" {
            keywordLabel.text = keyword
            goalLabel.text = goal
            totalCountLabel.text = "총 \(count)개"
            rateLabel.text = "\(rate)"
        } else {
            self.isHidden = true
        }
        
        UIView.animate(withDuration: 2, animations:  {() in
            self.rateSlider.setValue(0, animated: true)
                }, completion:{(Bool)  in
                    UIView.animate(withDuration: 2, animations: {() in
                        self.rateSlider.setValue(Float(rate), animated: true)
            })
        })
    }
    
    private func setKeywordView() {
        outlineView.layer.borderColor = UIColor.mainGray.cgColor
        outlineView.layer.cornerRadius = 13
        outlineView.layer.borderWidth = 1
    }
    
    private func setLabel() {
        keywordLabel.font = .myBoldSystemFont(ofSize: 21)
        keywordLabel.textColor = .mainBlack
        
        rateLabel.font = .myMediumSystemFont(ofSize: 32)
        rateLabel.textColor = .mainDarkOrange
        
        goalLabel.font = .myMediumSystemFont(ofSize: 12)
        goalLabel.textColor = .mainGray
        
        totalCountLabel.font = .myMediumSystemFont(ofSize: 12)
        totalCountLabel.textColor = .mainGray
    }
}

//MARK: Slider
extension EvaluationKeywordTVC {
    private func setSlider() {
        setSliderColor()
        rateSlider.setThumbImage(self.rateSliderThumbImage(with: self.rateSlider.value), for: UIControl.State.normal)
        rateSlider.setThumbImage(self.rateSliderThumbImage(with: self.rateSlider.value), for: UIControl.State.selected)
        rateSlider.isUserInteractionEnabled = false
    }
    
    private func rateSliderThumbImage(with progress: Float) -> UIImage {
        let layer = CALayer()
        layer.backgroundColor = UIColor.mainOrange.cgColor
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
        gradientLayer.cornerRadius = 2.5
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.mainOrange.cgColor, UIColor.mainLightOrange.cgColor, UIColor.mainPaleOrange.cgColor,  UIColor.white.cgColor]
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
