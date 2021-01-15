//
//  GoalWriteVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/07.
//

import UIKit
import Moya

class GoalWriteVC: UIViewController {
    private let authProvider = MoyaProvider<GoalService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var write = false
    var date = Date()
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewCount: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    var goalDataKeywordID: Int?
    var goalKeywordName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setUI()
        placeholderSetting()
        
    }
    @IBAction func saveButton(_ sender: Any) {
        writeGoal()
        self.navigationController?.popViewController(animated: true)
    }
    
    var weakClosure: (() -> Void)?

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
            self.weakClosure!()
        }
}

extension GoalWriteVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    func setUI(){
        textLabel.text = "\(goalKeywordName ?? "")에\n가까워 지기 위한 목표"
        textLabel.numberOfLines = 2
        textLabel.font = .myMediumSystemFont(ofSize: 25)
        textLabel.textColor = .mainBlack
        textLabel.sizeToFit()
        
        let fontSize = UIFont.myBlackSystemFont(ofSize: 25)
        let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (textLabel.text! as NSString).range(of: "\(goalKeywordName ?? "")"))
        textLabel.attributedText = attributedStr
        
        textView.backgroundColor = .gray30
        textView.layer.cornerRadius = 15
        
        textViewCount.textColor = .mainOrange
        
        saveButton.isEnabled = false
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .mainGray
        saveButton.setTitle("작성완료", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
    }
    
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
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func DateInMilliSeconds()-> Int
    {
        return Int(date.startOfWeek!.timeIntervalSince1970 * 1000)
    }
    
    @objc func dismissVC(){
        if write {
            cancelAlertaction()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func cancelAlertaction() {
        
        let alert = UIAlertController(
            title: "정말 뒤로 가시겠어요?",
            message: "뒤로가기를 누르시면 작성 중인 내용이\n삭제되고 이전 페이지로 돌아 갑니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        let cancel = UIAlertAction(title: "뒤로가기", style: .default) {
            _ in
            self.navigationController?.popViewController(animated: true)
        }
        let okAction = UIAlertAction(title: "취소하기", style: .default)
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension GoalWriteVC: UITextViewDelegate{
    func placeholderSetting() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 15)
        textView.text = "이번에는 어떤 목표를 이루고 싶나요?"
        textView.textColor = UIColor.lightGray
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.mainBlack
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "조금 더 자세한 내용을 알려주세요!"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count -  range.length
        return newLength <= 25
    }

    func textViewDidChange(_ textView: UITextView) {
        write = true
        textViewCount.text = "\(textView.text.count)"
        if textView.text.count == 0 {
            saveButton.isEnabled = false
            saveButton.layer.cornerRadius = 15
            saveButton.backgroundColor = .mainGray
            saveButton.setTitle("작성완료", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        }
        else{
            saveButton.isEnabled = true
            saveButton.layer.cornerRadius = 15
            saveButton.backgroundColor = .mainOrange
            saveButton.setTitle("작성완료", for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
        }
    }
}

// MARK: - 통신
extension GoalWriteVC{
    func writeGoal(){
        let param = GoalWriteRequest.init(DateInMilliSeconds(), self.goalDataKeywordID!, self.textView.text!)
        authProvider.request(.goalwrite(param: param)) { response in
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
