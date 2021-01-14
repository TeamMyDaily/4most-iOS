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
    
    var keywordID: Int?
    var taskID: Int?
    var taskTitle: String?
    var modify = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    @IBAction func saveButton(_ sender: Any) {
        postingTask()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func modifyButton(_ sender: Any) {
        modifyTask()
        self.navigationController?.popViewController(animated: true)
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
        
        let leftButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(dismissVC))
            button.tintColor = .mainBlack
            return button
        }()
        
        navigationItem.leftBarButtonItem = leftButton
        let modifyRightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btn_edit"), style: .plain, target: self, action: #selector(changeModify))
            button.tintColor = .mainOrange
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
            
            return button
        }()
        
        if dailyTask?.data != nil{
            navigationItem.rightBarButtonItem = modifyRightButton
        }
        
    }
    @objc func changeModify(){
        let deleteRightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "btn_trash"), style: .plain, target: self, action: #selector(deleteButton))
            button.tintColor = .mainOrange
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
            
            return button
        }()
        self.navigationItem.rightBarButtonItem = deleteRightButton
        todayTitle.isEnabled = true
        todayTextView.isEditable = true
        postingButton.isHidden = false
        todayTextView.backgroundColor = .mainLightGray2
        todayTextView.borderWidth = 0
        saveButton.isHidden = true
    }
    
    func setUI(){
        scoreSlider.addTarget(self, action: #selector(textFieldDidChange), for: .allEvents)
        textLabel.sizeToFit()
        textLabel.text = "\(taskTitle ?? "")에 관한\n행동을 기록해주세요"
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
        
        todayTitle.setLeftPaddingPoints(3)
        
        todayTitle.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        todayTextView.delegate = self
        todayTextView.layer.cornerRadius = 15
        todayTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        postingButton.backgroundColor = UIColor.mainGray
        postingButton.layer.cornerRadius = 15
        postingButton.setTitle("저장할래요", for: .normal)
        postingButton.setTitleColor(.white, for: .normal)
        postingButton.titleLabel?.font = .myBlackSystemFont(ofSize: 18)
        postingButton.isEnabled = false
        
        saveButton.backgroundColor = UIColor.mainGray
        saveButton.layer.cornerRadius = 15
        saveButton.setTitle("작성완료", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .myBlackSystemFont(ofSize: 18)
        saveButton.isEnabled = false
        
        setTextViewUI()
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        self.modify = true
        labelCount.text = "\(todayTitle.text?.count ?? 0)"
        postingButton.backgroundColor = .mainOrange
        postingButton.isEnabled = true
        
        if !(todayTitle.text!.isEmpty) && !(todayTextView.text.isEmpty) && self.todayScore.text != "0점"{
            saveButton.backgroundColor = .mainOrange
            saveButton.isEnabled = true
        }
        else{
            saveButton.backgroundColor = .mainGray
            saveButton.isEnabled = false
        }
    }
    
    func setTextViewUI(){
        if dailyTask?.data == nil { //초기작성
            placeholderSetting()
            todayTextView.backgroundColor = .mainLightGray2
            todayTitle.font = .myRegularSystemFont(ofSize: 16)
            todayTitle.textColor = .mainBlack
            todayTitle.placeholder = "오늘 하루 무슨일이 있었나요?"
            postingButton.isHidden = true
            saveButton.isHidden = false
            todayTitle.layer.addBorder([.bottom], color: .mainOrange, width: 1, move: 5)
        }
        else{ //이미 작성정보 있을시
            todayTextView.isEditable = false
            todayTitle.isEnabled = false
            todayTextView.borderWidth = 1
            todayTextView.backgroundColor = .white
            todayTextView.borderColor = .mainOrange
            todayTextView.text = dailyTask?.data.detail
            todayTextView.textColor = .mainBlack
            todayTitle.text = dailyTask?.data.title
            scoreSlider.value = Float(dailyTask?.data.satisfaction ?? 0)
            scoreSlider.thumbTintColor = .mainOrange
            for i in 0..<Int(dailyTask?.data.satisfaction ?? 0){
                sliderIndex[i].layer.backgroundColor = UIColor.mainOrange.cgColor
            }
            todayScore.text = "\(dailyTask?.data.satisfaction ?? 0)점"
            labelCount.text = String(dailyTask?.data.title.count ?? 0)
            textViewCount.text = String(dailyTask?.data.detail.count ?? 0)
            postingButton.isHidden = true
            saveButton.isHidden = true
            
            //            todayTitle.layer.addBorder([.bottom], color: .mainOrange, width: 1, move: 5)
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
        return newLength <= 500
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewCount.text = "\(textView.text.count)"
        self.modify = true
        postingButton.backgroundColor = .mainOrange
        postingButton.isEnabled = true
        
        if !(todayTitle.text!.isEmpty) && textViewCount.text != "0" && self.todayScore.text != "0점"{
            saveButton.backgroundColor = .mainOrange
            saveButton.isEnabled = true
        }
        else{
            saveButton.backgroundColor = .mainGray
            saveButton.isEnabled = false
        }
    }
}

//MARK:: - selector
extension DailyWriteVC {
    @objc func cancelAlertaction() {
        let alert = UIAlertController(
            title: "정말 뒤로 가시겠어요?",
            message: "뒤로가기를 누르시면 작성 중인 내용이 삭제\n되고 이전 페이지로 돌아 갑니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        let cancel = UIAlertAction(title: "확인", style: .default) {
            _ in
            self.navigationController?.popViewController(animated: true)
        }
        let okAction = UIAlertAction(title: "취소", style: .default)
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func deleteButton() {
        let alert = UIAlertController(
            title: "기록을 삭제 하시겠어요?",
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        let cancel = UIAlertAction(title: "삭제하기", style: .default) {_ in
            self.deleteTask()
            self.navigationController?.popViewController(animated: true)
        }
        let okAction = UIAlertAction(title: "취소하기", style: .default)
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissVC(){
        if dailyTask?.data != nil{
            if modify {
                cancelAlertaction()
            }
            self.navigationController?.popViewController(animated: true)
        }
        else{
            if textViewCount.text == "0" && labelCount.text == "0"{
                self.navigationController?.popViewController(animated: true)
            }
            cancelAlertaction()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK:: - Network
extension DailyWriteVC {
    func getDailyTask(){
        authProvider.request(.dailytask(self.taskID ?? 0)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(DailyTaskModel.self)
                    self.dailyTask = data
                    self.setUI()
                    self.setupNavigationBar()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func postingTask(){
        let param = DailyWriteRequest.init(self.keywordID!, self.todayTitle.text!, todayTextView.text!, Int(scoreSlider.value))
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
        authProvider.request(.dailyModify(id: (self.dailyTask?.data.id)!, param: param)) { response in
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
        authProvider.request(.dailyDelete(self.taskID!)) { [weak self] result in
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
