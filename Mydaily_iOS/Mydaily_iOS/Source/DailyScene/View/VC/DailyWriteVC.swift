//
//  DailyWriteVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/06.
//

import UIKit
import Moya

class DailyWriteVC: UIViewController {
    
    private let authProvider = MoyaProvider<DailyService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var dailyTask: DailyTaskModel?
    var dailyModify: DailyModifyModel?
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var todayTitle: UITextField!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var textViewCount: UILabel!
    @IBOutlet weak var todayTextView: UITextView!
    @IBOutlet weak var scoreSlider: UISlider!
    @IBOutlet weak var todayScore: UILabel!
    @IBOutlet var sliderIndex: [UIView]!
    @IBOutlet weak var postingButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var taskID: Int?
    var taskTitle: String?
    
    let modifyRightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(changeModify))
        button.setTitleTextAttributes([
                                        NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                        NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
        button.setTitleTextAttributes([
                                        NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                        NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
        
        return button
    }()
    let deleteRightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "삭제", style: .done, target: self, action: #selector(deleteTask))
        button.setTitleTextAttributes([
                                        NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                        NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
        button.setTitleTextAttributes([
                                        NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                        NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
        
        return button
    }()
    
    @objc func changeModify(){
        self.navigationItem.rightBarButtonItem = deleteRightButton
        postingButton.isHidden = true
        saveButton.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        setUI()
        getDailyTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTitle.delegate = self
        setSliderUI()
    }
    
    func setSliderUI(){
        for i in 0...4{
            sliderIndex[i].layer.cornerRadius = sliderIndex[i].frame.height/2
            sliderIndex[i].layer.backgroundColor = UIColor.mainGray.cgColor
        }
        scoreSlider.thumbTintColor = .mainGray
        scoreSlider.minimumTrackTintColor = UIColor.mainOrange
        scoreSlider.maximumTrackTintColor = UIColor.mainGray
    }
    
    @IBAction func changeSlider(_ sender: Any) {
        scoreSlider.value = roundf(scoreSlider.value)
        todayScore.text = "\(Int(scoreSlider.value))점"
        scoreSlider.thumbTintColor = .mainOrange
        todayScore.textColor = .mainOrange
        
        for i in 0..<Int(scoreSlider.value) {
            sliderIndex[i].layer.backgroundColor = UIColor.mainOrange.cgColor
        }
        for i in Int(scoreSlider.value)..<5 {
            sliderIndex[i].layer.backgroundColor = UIColor.mainGray.cgColor
        }
    }
}

extension DailyWriteVC {
    
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        self.navigationItem.title = "기록"
        
        //        let leftButton: UIBarButtonItem = {
        //            let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
        //            return button
        //        }()
        
//        navigationItem.leftBarButtonItem = leftButton
        
        if dailyTask?.data != nil{
            navigationItem.rightBarButtonItem = modifyRightButton
        }
        
    }
    
    @objc func post(){
//        posting()
//        modify()
//        delete()
    }
    
    func setUI(){
        textLabel.sizeToFit()
        textLabel.text = "\(taskTitle ?? "")으로 채운\n하루에 대해 알려주세요"
        textLabel.numberOfLines = 2
        textLabel.font = .myMediumSystemFont(ofSize: 24)
        //내가 적용하고싶은 폰트 사이즈
        let fontSize = UIFont.myBlackSystemFont(ofSize: 24)
        let attributedStr = NSMutableAttributedString(string: textLabel.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (textLabel.text! as NSString).range(of: "\(taskTitle ?? "")"))
        textLabel.attributedText = attributedStr
        
        labelCount.font = .myRegularSystemFont(ofSize: 12)
        labelCount.textColor = .mainOrange
        textViewCount.textColor = .mainOrange
        
        todayTextView.delegate = self
        todayTitle.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        setTextViewUI()
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        labelCount.text = "\(todayTitle.text?.count ?? 0)"
    }
    
    func setTextViewUI(){
        if dailyTask?.data == nil { //초기작성
            placeholderSetting()
            todayTextView.backgroundColor = .mainLightGray2
            todayTextView.layer.cornerRadius = 15
            
            todayTitle.setLeftPaddingPoints(3)
            todayTitle.layer.addBorder([.bottom], color: .mainOrange, width: 1, move: 5)
            todayTitle.font = .myRegularSystemFont(ofSize: 16)
            todayTitle.textColor = .mainBlack
            todayTitle.placeholder = "오늘 하루 무슨일이 있었나요?"
        }
        else{ //이미 작성정보 있을시
            todayTextView.borderWidth = 1
            todayTextView.backgroundColor = .white
            todayTextView.borderColor = .mainOrange
            todayTextView.text = dailyTask?.data.detail
            todayTitle.text = dailyTask?.data.title
            scoreSlider.value = Float(dailyTask?.data.satisfaction ?? 0)
            todayScore.text = String(dailyTask?.data.satisfaction ?? 0)
            labelCount.text = String(dailyTask?.data.title.count ?? 0)
            textViewCount.text = String(dailyTask?.data.detail.count ?? 0)
        }
    }
}


//MARK:: -TextField
extension DailyWriteVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if !updatedText.isEmpty {
            if updatedText.count <= 20{
                return true
            }
            else{
                return false
            }
        }
        else{
            return true
        }
    }
}

//MARK:: -TextViewDelegate
extension DailyWriteVC: UITextViewDelegate {
    
    func placeholderSetting() {
        todayTextView.font = .myRegularSystemFont(ofSize: 15)
        todayTextView.text = "조금 더 자세한 내용을 알려주세요!"
        todayTextView.textColor = UIColor.lightGray
        todayTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        if textView.textColor == UIColor.mainGray {
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
        return newLength <= 500
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewCount.text = "\(textView.text.count)"
    }
}


//MARK:: - Network
extension DailyWriteVC {
    func getDailyTask(){
        authProvider.request(.dailytask(1)) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    do {
                        let data = try response.map(DailyTaskModel.self)
                        print("&&")
                        self.dailyTask = data
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func postingTask(){
        let param = DailyWriteRequest.init("\(taskID ?? 1)", self.todayTitle.text!, todayTextView.text!, Int(scoreSlider.value))
        authProvider.request(.dailyWrite(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        self.dailyTask = try result.map(DailyTaskModel.self)
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    @objc func modifyTask(){
        let param = DailyModifyRequest.init(self.todayTitle.text!, todayTextView.text!, Int(scoreSlider.value))
        authProvider.request(.dailyModify(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        self.dailyModify = try result.map(DailyModifyModel.self)
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    @objc func deleteTask(){
        authProvider.request(.dailyDelete(taskID!)) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    do {
                        self.dailyModify = try response.map(DailyModifyModel.self)
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
