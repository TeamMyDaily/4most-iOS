//
//  GoalModifyVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/10.
//

import UIKit

class GoalModifyVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var textViewCount: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setUI()
    }
    
    @IBAction func saveButton(_ sender: Any) {
    }
}

extension GoalModifyVC {
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "목표"
        
        //        let leftButton: UIBarButtonItem = {
        //            let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
        //            return button
        //        }()
        
        let rightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(title: "삭제", style: .done, target: self, action: nil)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
            
            return button
        }()
        
//                let leftButton: UIBarButtonItem = {
//                    let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
//                    return button
//                }()
//                navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setUI(){
        goalTextView.delegate = self
        dateLabel.text = "20년 12월 3주"
        dateLabel.font = .boldSystemFont(ofSize: 12)
        dateLabel.textColor = .mainGray
    
        keywordLabel.text = "아웃풋에\n가까워 지기 위한 목표"
        keywordLabel.numberOfLines = 2
        keywordLabel.font = .myMediumSystemFont(ofSize: 25)
        keywordLabel.textColor = .mainBlack
        keywordLabel.sizeToFit()
        
        let fontSize = UIFont.myBlackSystemFont(ofSize: 25)
        let attributedStr = NSMutableAttributedString(string: keywordLabel.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (keywordLabel.text! as NSString).range(of: "아웃풋"))
        keywordLabel.attributedText = attributedStr
        
        goalTextView.backgroundColor = .gray30
        goalTextView.layer.cornerRadius = 15
        
        textViewCount.textColor = .mainOrange
        textViewCount.font = .myRegularSystemFont(ofSize: 12)
        
        saveButton.isEnabled = false
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .mainGray
        saveButton.setTitle("저장할래요", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
    }
}

extension GoalModifyVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count -  range.length
        return newLength <= 25
    }

    func textViewDidChange(_ textView: UITextView) {
        textViewCount.text = "\(textView.text.count)"
        if textView.text.count == 0 {
            saveButton.isEnabled = false
            saveButton.layer.cornerRadius = 15
            saveButton.backgroundColor = .mainGray
            saveButton.setTitle("저장할래요", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        }
        else{
            saveButton.isEnabled = true
            saveButton.layer.cornerRadius = 15
            saveButton.backgroundColor = .mainOrange
            saveButton.setTitle("저장할래요", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
        }
    }
}
