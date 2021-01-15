//
//  NextKeywordVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/05.
//

import UIKit
import Moya

class NextKeywordVC: UIViewController {
    static let identifier = "NextKeywordVC"
    
    private let authProvider = MoyaProvider<KeywordServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var responseToken : SelectedKeywordsModel?
    
    var keywordList: [[String]] = []
    
    @IBOutlet weak var keywordContentView: UIView!
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
   
    var selectedKeywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setkeywordContentView()
        setCompleteButton()
        setTitleLabel()
        setNavigationBar()
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "8가지를 고르셨군요!\n조금만 더 고민해 볼까요?"
    }
    
    func setCompleteButton(){
        completeButton.setTitle("키워드 선택완료", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 18)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    
    @IBAction func submitKeyword(_ sender: UIButton) {
        
        postSelectedKeyword()
        guard let dvc = self.storyboard?.instantiateViewController(identifier: KeywordPriorityVC.identifier) as? KeywordPriorityVC else{
            return
        }
        
        dvc.setReceivedKeywordList(list: selectedKeywordList)
        self.navigationController?.pushViewController(dvc, animated: true)

    }
    
    func setkeywordContentView(){
        
        let content = UIView(frame: CGRect(x: 0, y: 0, width: keywordContentView.frame.width, height:keywordContentView.frame.height))
        var contentX = 0
        var contentY = 0
        let systemSize = Int(view.frame.size.width)
       
        for i in 0..<3{
            if keywordList[i].count != 0{
                let keywordTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: keywordContentView.frame.width, height: 32))
                keywordTitleLabel.text = ""
                keywordTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
                keywordTitleLabel.frame.origin.y = CGFloat(contentY)
                contentX = 0
                
                if i == 0 {
                    keywordTitleLabel.text = "삶을 대하는 자세"
                }
                if i == 1{
                    keywordTitleLabel.text = "일을 대하는 자세"
                }
                
                if i == 2{
                    keywordTitleLabel.text = "내가 추가한 키워드"
                    keywordTitleLabel.textColor = UIColor.mainOrange
                }
                
                content.addSubview(keywordTitleLabel)
                contentY += 40
                
                for j in 0..<keywordList[i].count{
                    let buttonWidth = addKeywordButton(view: content, text: keywordList[i][j], contentX: contentX, contentY: contentY)
                    contentX += buttonWidth + 8
                    
                    if contentX > systemSize - 100 && j != keywordList[i].count - 1 {
                        contentX = 0
                        contentY += 48
                    }
                    
                    content.addSubview(keywordTitleLabel)
                    
                }
                
                contentY += 65
            }
            
        }
        keywordContentView.addSubview(content)
        
    }

   
    func setReceivedKeywordList(list: [[String]]){
        keywordList = list
    }
    
    func addKeywordButton(view: UIView, text: String, contentX: Int, contentY: Int) -> Int{
        
        let buttonWidth = text.count * 17 + 24
        
        let keywordButton = UIButton(frame: CGRect(x: contentX, y: contentY, width: buttonWidth, height: 32))

        keywordButton.titleEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 5, right: 12)
        keywordButton.setTitle(text, for: .normal)
        keywordButton.setTitleColor(.white, for: .normal)
        keywordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        keywordButton.layer.cornerRadius = 15
        keywordButton.backgroundColor = UIColor.mainGray
        
        keywordButton.addTarget(self, action: #selector(selectKeyword), for: .touchUpInside)
    
        view.addSubview(keywordButton)
        
        return buttonWidth
    }
    
    
    @objc func selectKeyword(_ sender: UIButton){
        let selectedText = sender.titleLabel?.text ?? ""
        
        if selectedKeywordList.count < 4 {
            if sender.backgroundColor == UIColor.mainGray{
                selectedKeywordList.append(selectedText)
                sender.backgroundColor = UIColor.mainOrange
            }else{
                let index = selectedKeywordList.firstIndex(of: selectedText) ?? 0
                selectedKeywordList.remove(at: index)
                sender.backgroundColor = UIColor.mainGray
            }
            
        }else if selectedKeywordList.count == 4 && sender.backgroundColor != UIColor.mainGray{
            let index = selectedKeywordList.firstIndex(of: selectedText) ?? 0
            selectedKeywordList.remove(at: index)
            sender.backgroundColor = UIColor.mainGray
            
        }else{
            alertKeyword()
        }
        
        setButtonActive()
        printSelectedKeyword()
    }
    
    func alertKeyword(){
        let txt = "키워드를 많이 선택 하셨어요.\n키워드는 4개 까지 선택이 가능합니다.\n좀 더 고민해서 하나를 제외 해 주세요!"
        let alert = UIAlertController(title: "최종 키워드 4개를 선택해주세요", message: txt, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인했어요", style: .default) { (action) in}
       
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    func setButtonActive(){
        if selectedKeywordList.count > 0 && selectedKeywordList.count < 5 {
            completeButton.backgroundColor = UIColor.mainOrange
            completeButton.isEnabled = true
        }else{
            completeButton.backgroundColor = UIColor.mainGray
            completeButton.isEnabled = false
        }
    }
    
    func printSelectedKeyword(){
        print("--------------선택한 키워드-----------")
        for txt in selectedKeywordList{
            print(txt)
        }
    }
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 설정하기"
        let questionMark = UIImage(named: "btn_question" )
        let questionItem = UIBarButtonItem(image: questionMark, style: .plain, target: self, action: #selector(goKeywordPopUp))
        questionItem.tintColor = UIColor.mainOrange
        navigationItem.rightBarButtonItem = questionItem
        
        let leftButton: UIBarButtonItem = {
             let button = UIBarButtonItem(image: UIImage(named: "btnBack"), style: .plain, target: self, action: #selector(dismissVC))
            button.tintColor = UIColor.mainBlack
             return button
           }()
           navigationItem.leftBarButtonItem = leftButton
    }

    
    @objc func dismissVC() {
      self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func goKeywordPopUp(){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "KeywordPopUpVC") else {
            return
        }
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }

}

// MARK: - Network
extension NextKeywordVC{
    func postSelectedKeyword(){
        let param = SelectedKeywordsRequest(list: selectedKeywordList)
        authProvider.request(.selectedKeywords(param: param)){ responds in
            switch responds {
            case .success(let result):
                do {
                    self.responseToken = try result.map(SelectedKeywordsModel.self)
                    guard let dvc = self.storyboard?.instantiateViewController(identifier: KeywordPriorityVC.identifier) as? KeywordPriorityVC else{
                        return
                    }
                    
                    dvc.setReceivedKeywordList(list: self.selectedKeywordList)
                    self.navigationController?.pushViewController(dvc, animated: true)

                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
