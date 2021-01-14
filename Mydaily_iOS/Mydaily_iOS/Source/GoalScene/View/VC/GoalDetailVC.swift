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
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var goalButton: UIButton!
    var goal = false
    var KeywordDate: GoalKeyword?
    var week: String?
    var completed: Bool?
    var edit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goal = self.KeywordDate?.isGoalCompleted ?? false
        setupNavigationBar()
        setUI()
    }
    
    @IBAction func checkButton(_ sender: Any) {
        if goal == false {
            checkButton.setImage(UIImage(named: "ic_check_line_active"), for: .normal)
            checkLabel.textColor = .mainOrange
            goal = true
        }
        else{
            checkButton.setImage(UIImage(named: "ic_check_line_inactive"), for: .normal)
            checkLabel.textColor = .mainGray
            goal = false
        }
    }
    
    @IBAction func completeButton(_ sender: Any) {
        let alert = self.storyboard?.instantiateViewController(withIdentifier: "customPopVC") as! customPopVC
        
//        self.navigationController?.pushViewController(alert, animated: false)
        alert.modalPresentationStyle = .overCurrentContext
        present(alert, animated: false, completion: nil)
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
        
        if completed != true{
            navigationItem.rightBarButtonItem = rightButton
        }
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func modify(){
        guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalModifyVC") as? GoalModifyVC else {return}
        VC.KeywordDate = self.KeywordDate
        VC.week = self.week
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func setUI(){
        checkLabel.text = "목표 달성시 체크"
        checkLabel.font = .myLightSystemFont(ofSize: 12)
        
        goalButton.isEnabled = false
        goalButton.layer.cornerRadius = 15
        goalButton.setTitle("목표 달성", for: .normal)
        goalButton.setTitleColor(.white, for: .normal)
        goalButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        
        if completed == true{
            checkButton.setImage(UIImage(named: "ic_check_line_active"), for: .normal)
            checkButton.isEnabled = false
            goalButton.isEnabled = false
            goalButton.backgroundColor = .mainOrange
            checkLabel.textColor = .mainOrange
        }else{
            checkButton.setImage(UIImage(named: "ic_check_line_inactive"), for: .normal)
            checkLabel.textColor = .mainGray
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
        
        checkButton.addTarget(self, action: #selector(enabledButton), for: .allEvents)
    }
    
    func updateUI(){
        
    }
    
    @objc func enabledButton() {
        if goal == true {
            goalButton.backgroundColor = .mainOrange
            goalButton.isEnabled = true
        }
        else{
            goalButton.backgroundColor = .mainGray
            goalButton.isEnabled = false
        }
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
