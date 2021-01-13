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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setUI()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        modifyGoal()
        self.navigationController?.popViewController(animated: true)
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
                    let button = UIBarButtonItem(title: "뒤", style: .plain, target: self, action: #selector(cancelAlertaction))
                    return button
                }()
        
        let rightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(title: "삭제", style: .done, target: self, action: #selector(deleteAlert))
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
        
        let alert = UIAlertController(
            title: "주의!",
            message: "작성중인 글을 취소하시겠습니까?\n취소할 시, 작성된 글은 저장되지 않습니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        let cancel = UIAlertAction(title: "작성취소", style: .destructive) {
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        let okAction = UIAlertAction(title: "닫기", style: .default)
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func deleteAlert(){
        let alertViewController = UIAlertController(title: "목표를 삭제 하시겠어요?", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "취소하기", style: .cancel, handler : nil)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
        //Implement action
            self.deleteGoal()
        }
        
        alertViewController.addAction(alertAction)
        alertViewController.addAction(deleteAction)
        
        present(alertViewController, animated: false, completion: nil)
    }
    
    func setUI(){
        goalTextView.delegate = self
        dateLabel.text = "20년 12월 3주"
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

// MARK: - 통신
extension GoalModifyVC{
    func modifyGoal(){
        let param = GoalModifyRequest.init("gg")
        authProvider.request(.goalmodify(param: param)) { response in
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
