//
//  GoalDetailVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/10.
//

import UIKit
import Moya

class GoalDetailVC: UIViewController {
    private let authProvider = MoyaProvider<GoalService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var backToEvaluationDetail: (() -> ())?
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalButton: UIButton!
    var goal = false
    var KeywordDate: GoalKeyword?
    var week: String?
    var completed: Bool?
    var edit = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        goal = self.KeywordDate?.isGoalCompleted ?? false
        setupNavigationBar()
        setUI()
    }
    
    @IBAction func completeButton(_ sender: Any) {
        
        if completed == false{
            goalButton.backgroundColor = .mainOrange
        let alert = self.storyboard?.instantiateViewController(withIdentifier: "customPopVC") as! customPopVC
        
        alert.modalPresentationStyle = .overCurrentContext
            present(alert, animated: false, completion: nil)
        }
        else{
            goalButton.backgroundColor = .mainGray
            self.navigationController?.popViewController(animated: true)
        }
        completeGoal()
    }
}

extension GoalDetailVC {
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "목표"
        
        let leftButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(dismissVC))
            button.tintColor = .mainBlack
            return button
        }()
        
        let rightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btn_edit"), style: .done, target: self, action: #selector(modify))
            button.tintColor = .mainOrange
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
            
            return button
        }()
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func dismissVC() {
        backToEvaluationDetail?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func modify(){
        guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalModifyVC") as? GoalModifyVC else {return}
        VC.KeywordDate = self.KeywordDate
        VC.week = self.week
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func setUI(){
        goalButton.layer.cornerRadius = 15
        goalButton.setTitle("목표 달성", for: .normal)
        goalButton.setTitleColor(.white, for: .normal)
        goalButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        
        if completed == true{
            goalButton.backgroundColor = .mainOrange
        }else{
            goalButton.backgroundColor = .mainGray
        }
        weekLabel.text = "\(week ?? "")"
        weekLabel.font = .myBoldSystemFont(ofSize: 12)
        weekLabel.textColor = .mainGray
        
        keywordLabel.text = "\(self.KeywordDate?.name ?? "")에 가까워지기 위한 목표"
        keywordLabel.font = .myMediumSystemFont(ofSize: 15)
        keywordLabel.textColor = .mainBlack
        
        let fontSize = UIFont.myBlackSystemFont(ofSize: 15)
        let attributedStr = NSMutableAttributedString(string: keywordLabel.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (keywordLabel.text! as NSString).range(of: "\(self.KeywordDate?.name ?? "")"))
        keywordLabel.attributedText = attributedStr
        
        
        goalLabel.text = "\(self.KeywordDate?.weekGoal ?? "")"
        goalLabel.numberOfLines = 2
        goalLabel.font = .myBlackSystemFont(ofSize: 32)
        goalLabel.textColor = .mainBlack
        goalLabel.sizeToFit()
    }
    
    func updateUI(){
        
    }
}
// MARK: - 통신
extension GoalDetailVC{
    func completeGoal(){
        authProvider.request(.goalcomplete((self.KeywordDate?.weekGoalID)!)) { response in
            switch response {
                case .success(let result):
                    do {
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
