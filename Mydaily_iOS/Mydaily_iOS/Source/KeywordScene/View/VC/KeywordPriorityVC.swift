//
//  KeywordPriorityVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/05.
//

import UIKit

class KeywordPriorityVC: UIViewController {
    static let identifier = "KeywordPriorityVC"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    var keywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCompleteButton()
        setTitleLabel()
        setTableViewDelegate()
        setNavigationBar()
    }
    
    func setTableViewDelegate(){
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        keywordTableView.isEditing = true
        keywordTableView.register(UINib(nibName: "KeywordPriorityTVC", bundle: .main), forCellReuseIdentifier: KeywordPriorityTVC.identifier)
        
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "키워드에 대한\n우선순위를 세워보세요!"
    }
    
    func setCompleteButton(){
        completeButton.titleLabel?.font =  UIFont(name: "System-Bold", size: 18.0)
        completeButton.layer.cornerRadius = 15
    }
    
    func setReceivedKeywordList(list: [String]){
        keywordList = list
    }
    
    @IBAction func submitKeyword(_ sender: UIButton) {
        
        guard let dvc = self.storyboard?.instantiateViewController(identifier: KeywordDecideVC.identifier) as? KeywordDecideVC else{
            return
        }
        
        dvc.setReceivedKeywordList(list: keywordList)
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 우선순위"
      
        let leftButton: UIBarButtonItem = {
             let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissVC))
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordPriorityTVC.identifier) as? KeywordPriorityTVC else{
            return UITableViewCell()
        }
       
        cell.setKeywordLabel(text: keywordList[indexPath.row])
        
        
        return cell
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
    
}


