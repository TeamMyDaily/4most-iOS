//
//  MypageVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class MypageVC: UIViewController {

    @IBOutlet weak var keywordSettingButton: UIButton!
    @IBOutlet var keywordTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    var keywordList: [String] = ["아웃풋", "열정", "선한영향력", "경청"]
    var userKeywordList: [String] = ["선한영향력", "경청", "친절함", "대충", "열정" ,"진실성", "존중", "신뢰","연어덮밥"]
    var pageNumber = 0
    var userName = "엄석준"
    var changeButton = UIButton()
    var recordCellList : [RecordKeywordTVC] = []
    var recordCell: RecordKeywordTVC = RecordKeywordTVC()
    var userCellList: [UserKeywordTVC] = []
    var userCell:UserKeywordTVC = UserKeywordTVC()
    var footer = UIView()
    var subTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setTitleLabel()
        setTableFooterView()
    }
    
    func setDelegate(){
        keywordTableView.dataSource = self
        keywordTableView.delegate = self
        keywordTableView.register(UINib(nibName: "RecordKeywordTVC", bundle: .main), forCellReuseIdentifier: RecordKeywordTVC.identifier)
        keywordTableView.register(UINib(nibName: "UserKeywordTVC", bundle: .main), forCellReuseIdentifier: UserKeywordTVC.identifier)
        
        if pageNumber == 0{
            keywordTableView.isScrollEnabled = false
        }else{
            keywordTableView.isScrollEnabled = true
        }
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "\(userName)님의\n목적지를 찾아봐요"
    }
    
    @IBAction func goToSettingKeywordView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Keyword", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "KeywordSettingVCNavigation")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)

    }
    
    
}

extension MypageVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageNumber == 0{
            return keywordList.count
        }else{
            return userKeywordList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if pageNumber == 0{
            recordCell = (tableView.dequeueReusableCell(withIdentifier: "RecordKeywordTVC") as? RecordKeywordTVC)!
            
            recordCell.setContent(rank: indexPath.row+1, keyword: keywordList[indexPath.row])
            
            if recordCellList.count <= keywordList.count{
            recordCellList.append(recordCell)
            }
            return recordCell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserKeywordTVC") as? UserKeywordTVC else{
                return UITableViewCell()
            }
            
            if keywordList.contains(userKeywordList[indexPath.row]){
                print(userKeywordList[indexPath.row])
                cell.setContent(selected: true, keyword: userKeywordList[indexPath.row])
            }else{
                cell.setContent(selected: false, keyword: userKeywordList[indexPath.row])
            }
            
            userCellList.append(cell)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //수정시 옆에 뜨는 - 버튼 없애기
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
}

extension MypageVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        keywordList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
        //recordCellList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    func setTableFooterView(){
        footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
    
        subTitle = UILabel(frame: CGRect(x: 0, y: 0, width:  view.frame.width, height: 60))
        subTitle.font = UIFont.myRegularSystemFont(ofSize: 12)
        subTitle.numberOfLines = 0
        subTitle.text = "이곳에서 우선순위를 변경하게 되면 기록, 회고, 목표에서\n변경한 순서대로 보여지게 됩니다."
        subTitle.textAlignment = .center
        subTitle.isHidden = true
        
        
        changeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        changeButton.setTitleColor(UIColor.mainGray, for: .normal)
        changeButton.setTitle("우선순위 변경 하기", for: .normal)
        changeButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        changeButton.tintColor = UIColor.mainGray
        changeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        changeButton.semanticContentAttribute = .forceRightToLeft
        changeButton.layer.cornerRadius = 15
        changeButton.center =  CGPoint(x: footer.frame.width / 2 - 10, y: 30)
        changeButton.addTarget(self, action: #selector(setEditingMode), for: .touchUpInside)
        
        
        footer.addSubview(subTitle)
        footer.addSubview(changeButton)
        
        keywordTableView.tableFooterView = footer
    }
    
    @objc func setEditingMode(_ sender: UIButton){
        if sender.title(for: .normal) == "우선순위 변경 하기"{
            sender.setTitle("우선순위 지정", for: .normal)
            sender.setImage(UIImage(), for: .normal)
            sender.setTitleColor(.white, for: .normal)
            sender.frame.size.width = CGFloat(120)
            sender.center =  CGPoint(x: footer.frame.width / 2 , y: 70)
            sender.backgroundColor = .mainGray
            
            subTitle.isHidden = false
            keywordTableView.isEditing = true
            
            
            for i in 0..<recordCellList.count{
                recordCellList[i].rankingNumber.isHidden = true
                
                recordCellList[i].rankingNumber.frame.size.width = 0
                
            }
            
                        
        }else{
            sender.setTitle("우선순위 변경 하기", for: .normal)
            sender.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            sender.setTitleColor(UIColor.mainGray, for: .normal)
            sender.frame.size.width = CGFloat(160)
            sender.center =  CGPoint(x: footer.frame.width / 2 , y: 20)
            sender.backgroundColor = .white
            subTitle.isHidden = true
            keywordTableView.isEditing = false
            
            for i in 0..<recordCellList.count{
                //recordCellList[i].rankingNumber.text = "\(i+1)"
                recordCellList[i].rankingNumber.constraint(recordCellList[i].widthAnchor, constant: CGFloat(20))
                recordCellList[i].rankingNumber.isHidden = false
                //recordCellList[i].rankingNumber.frame.size.width = 15
                recordCellList[i].keywordLabel.frame.origin.x = recordCellList[i].keywordLabel.frame.origin.x + 10

            }
            
            keywordTableView.reloadData()
            

        }
        
    }
    
}
