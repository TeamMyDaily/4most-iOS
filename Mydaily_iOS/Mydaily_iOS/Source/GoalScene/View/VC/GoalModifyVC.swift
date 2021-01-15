//
//  GoalModifyVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/10.
//

import UIKit
import Moya

class GoalModifyVC: UIViewController {
    private let authProvider = MoyaProvider<GoalService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var textViewCount: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    var KeywordDate: GoalKeyword?
    var week:String?
    var edit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setUI()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        modifyGoal()
        if let viewControllers = self.navigationController?.viewControllers {
            if viewControllers.count > 2 {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            } else {
                        // fail
            }
        }
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
        
        let leftButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(cancelAlertaction))
            button.tintColor = .mainBlack
            return button
        }()
        
        let rightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btn_trash"), style: .plain, target: self, action: #selector(deleteAlert))
            button.tintColor = .mainOrange
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
            
            return button
        }()
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    private func cancelAlertaction() {
        if edit == true{
            let alert = UIAlertController(
                title: "정말 뒤로 가시겠어요?",
                message: "뒤로가기를 누르시면 작성 중인 내용이 삭제\n되고 이전 페이지로 돌아 갑니다.",
                preferredStyle: UIAlertController.Style.alert
            )
            let cancel = UIAlertAction(title: "작성취소", style: .destructive) {_ in 
                self.navigationController?.popViewController(animated: true)
            }
            let okAction = UIAlertAction(title: "닫기", style: .default)
            alert.addAction(cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func deleteAlert(){
        let alertViewController = UIAlertController(title: "목표를 삭제 하시겠어요?", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "취소하기", style: .cancel, handler : nil)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
            self.deleteGoal()
            if let viewControllers = self.navigationController?.viewControllers {
                if viewControllers.count > 2 {
                    self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                } else {
                            // fail
                }
            }
        }
        
        alertViewController.addAction(alertAction)
        alertViewController.addAction(deleteAction)
        
        present(alertViewController, animated: false, completion: nil)
    }
    
    func setUI(){
        goalTextView.delegate = self
        dateLabel.text = "\(self.week ?? "")"
        dateLabel.font = .boldSystemFont(ofSize: 12)
        dateLabel.textColor = .mainGray
    
        keywordLabel.text = "\(self.KeywordDate?.name ?? "")에\n가까워 지기 위한 목표"
        keywordLabel.numberOfLines = 2
        keywordLabel.font = .myMediumSystemFont(ofSize: 25)
        keywordLabel.textColor = .mainBlack
        keywordLabel.sizeToFit()
        
        let fontSize = UIFont.myBlackSystemFont(ofSize: 25)
        let attributedStr = NSMutableAttributedString(string: keywordLabel.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (keywordLabel.text! as NSString).range(of: "\(self.KeywordDate?.name ?? "")"))
        keywordLabel.attributedText = attributedStr
        
        goalTextView.backgroundColor = .gray30
        goalTextView.layer.cornerRadius = 15
        goalTextView.text = "\(self.KeywordDate?.weekGoal ?? "")"
        goalTextView.textColor = .mainBlack
        goalTextView.font = .myRegularSystemFont(ofSize: 16)
        goalTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        textViewCount.textColor = .mainOrange
        textViewCount.font = .myRegularSystemFont(ofSize: 12)
        
        saveButton.isEnabled = false
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .mainGray
        saveButton.setTitle("저장할래요", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}

extension GoalModifyVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count -  range.length
        return newLength <= 25
    }

    func textViewDidChange(_ textView: UITextView) {
        edit = true
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

// MARK: - 통신
extension GoalModifyVC{
    func modifyGoal(){
        let param = GoalModifyRequest.init("\(self.goalTextView.text ?? "")")
        authProvider.request(.goalmodify(ID: self.KeywordDate?.weekGoalID ?? 0, param: param)) { response in
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

extension GoalModifyVC{
    func deleteGoal(){
        authProvider.request(.goaldelete(self.KeywordDate?.weekGoalID ?? 0)) { response in
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
