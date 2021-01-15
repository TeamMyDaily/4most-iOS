//
//  KeywordPriorityVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/05.
//

import UIKit
import Moya

class KeywordPriorityVC: UIViewController {
    static let identifier = "KeywordPriorityVC"
    
    private let authProvider = MoyaProvider<KeywordServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var responseToken : PriorityKeywordModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    var keywordList: [String] = []
    var priorityKeywordList: [PriorityKeyword] = []
    //var resultPriority:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCompleteButton()
        setTitleLabel()
        setTableViewDelegate()
        setNavigationBar()
        setTableViewHeight()
        keywordTableView.estimatedRowHeight = 50
       //keywordTableView.rowHeight = UITableView.automaticDimension
        //keywordTableView.backgroundColor = .red
        //keywordTableView.separatorStyle = .none
    }
    
    func setTableViewDelegate(){
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        keywordTableView.isEditing = true
        keywordTableView.register(UINib(nibName: "KeywordPriorityTVC", bundle: .main), forCellReuseIdentifier: KeywordPriorityTVC.identifier)
        
    }
    
    func setTableViewHeight(){
        keywordTableView.estimatedRowHeight = 50
        keywordTableView.rowHeight = UITableView.automaticDimension
//        var tableHeight = keywordList.count * 10
//        keywordTableView.frame.size.height = CGFloat(tableHeight)
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "키워드에 대한\n우선순위를 세워보세요!"
        titleLabel.font = UIFont.myBlackSystemFont(ofSize: 25)
    }
    
    func setCompleteButton(){
        completeButton.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 18)
        completeButton.layer.cornerRadius = 15
        completeButton.backgroundColor = UIColor.mainOrange
    }
    
    func setReceivedKeywordList(list: [String]){
        keywordList = list
    }
    
    @IBAction func submitKeyword(_ sender: UIButton) {
        
        for i in 0..<keywordList.count{
            priorityKeywordList.append(PriorityKeyword(name: keywordList[i], priority: i+1))
        }
        
        postKeywordPriority()
    }
    
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 우선순위"
      
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
   
    
}

extension KeywordPriorityVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordPriorityTVC.identifier) as? KeywordPriorityTVC else{
            return UITableViewCell()
        }
       
        cell.setKeywordLabel(text: keywordList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 2))
        headerView.backgroundColor = .mainGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 2))
        footerView.backgroundColor = .mainGray
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 2
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //수정시 옆에 뜨는 - 버튼 없애기
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
}

extension KeywordPriorityVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        keywordList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension KeywordPriorityVC{
    func postKeywordPriority(){
        let param = PriorityKeywordRequest(list: priorityKeywordList)
        authProvider.request(.priorityKeyword(param: param)){ responds in
            switch responds {
            case .success(let result):
                do {
                    print("와이라노 \(result.statusCode)")
                    self.responseToken = try result.map(PriorityKeywordModel.self)
                    
                    guard let dvc = self.storyboard?.instantiateViewController(identifier: KeywordDecideVC.identifier) as? KeywordDecideVC else{
                        return
                    }

                    dvc.setReceivedKeywordList(list: self.keywordList)
                    self.navigationController?.pushViewController(dvc, animated: true)

                } catch(let err){
                    if result.statusCode == 200{
                        guard let dvc = self.storyboard?.instantiateViewController(identifier: KeywordDecideVC.identifier) as? KeywordDecideVC else{
                            return
                        }

                        dvc.setReceivedKeywordList(list: self.keywordList)
                        self.navigationController?.pushViewController(dvc, animated: true)
                    }
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
}


