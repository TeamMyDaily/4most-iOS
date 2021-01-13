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
    
    let keywordStoryboard = UIStoryboard(name: "Keyword", bundle: nil)
    
    @IBOutlet var recordKeywordButton: UIButton!
    @IBOutlet var recordKeywordBarView: UIView!
    
    @IBOutlet var userKeywordBarView: UIView!
    @IBOutlet var userKeywordButton: UIButton!
    
    var footer = UIView()
    var header = UIView()
    var subTitle = UILabel()
    var changeButton = UIButton()
    var plusButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setTitleLabel()
        setButton()
        setNavigationBar()
        setInitTableFooterView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func goToSettingKeywordView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Keyword", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "KeywordSettingVCNavigation")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)

    }
    
    @IBAction func touchUpRecordKeyword(_ sender: UIButton){
        if sender.title(for:.normal) == "기록키워드"{
            pageNumber = 0
            recordKeywordButton.setTitleColor(UIColor.mainOrange, for: .normal)
            userKeywordButton.setTitleColor(UIColor.mainGray, for: .normal)
            recordKeywordBarView.isHidden = false
            userKeywordBarView.isHidden = true
            keywordTableView.isScrollEnabled = false
            setRecordFooter()
            deleteHeaderView()
        }else{
            pageNumber = 1
            recordKeywordButton.setTitleColor(UIColor.mainGray, for: .normal)
            userKeywordButton.setTitleColor(UIColor.mainOrange, for: .normal)
            keywordTableView.isEditing = false
            recordKeywordBarView.isHidden = true
            userKeywordBarView.isHidden = false
            keywordTableView.isScrollEnabled = true
            setKeywordListFooter()
            setHeaderView()
        }
        keywordTableView.reloadData()
        
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
            let recordCell = (tableView.dequeueReusableCell(withIdentifier: "RecordKeywordTVC") as? RecordKeywordTVC)!
            
            recordCell.setContent(rank: indexPath.row+1, keyword: keywordList[indexPath.row])
            if subTitle.isHidden == false{ // 우선순위 정하는 중
               
                recordCell.rankingNumber.isHidden = true
                UIView.animate(withDuration: 0.1) {
                    recordCell.keywordLabel.transform = CGAffineTransform(translationX: -30, y: 0)
                }
            }else{
                recordCell.rankingNumber.isHidden = false
                UIView.animate(withDuration: 0.1) {
                    recordCell.keywordLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }
            
            
            return recordCell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserKeywordTVC") as? UserKeywordTVC else{
                return UITableViewCell()
            }
            cell.cellDelegate = self
            
            let isSelectedKeyword = keywordList.contains(userKeywordList[indexPath.row]) ? true : false
            cell.setContent(selected: isSelectedKeyword, keyword: userKeywordList[indexPath.row])
            
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
        
    }
    
    func setHeaderView(){
        header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let listDescription = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        listDescription.text = "\(userName)님이 추구하는 가치관이에요!"
        listDescription.textColor = UIColor.mainGray
        
        header.addSubview(listDescription)
        keywordTableView.tableHeaderView = header
    }
    
    func deleteHeaderView(){
        header.removeFromSuperview()
        keywordTableView.tableHeaderView = nil
    }
    
    func setInitTableFooterView(){
        footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        setRecordFooter()
        keywordTableView.tableFooterView = footer
    }
    
    func setRecordFooter(){
        for object in footer.subviews{
            object.removeFromSuperview()
        }
        
        subTitle = UILabel(frame: CGRect(x: -10, y: 0, width: UIScreen.main.bounds.width, height: 60))
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
        changeButton.center =  CGPoint(x: footer.frame.width / 2 , y: 30)
        changeButton.addTarget(self, action: #selector(setEditingMode), for: .touchUpInside)
        
        footer.addSubview(subTitle)
        footer.addSubview(changeButton)
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
            
        }else{
            sender.setTitle("우선순위 변경 하기", for: .normal)
            sender.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            sender.setTitleColor(UIColor.mainGray, for: .normal)
            sender.frame.size.width = CGFloat(160)
            sender.center =  CGPoint(x: footer.frame.width / 2 , y: 20)
            sender.backgroundColor = .white
            
            subTitle.isHidden = true
            keywordTableView.isEditing = false
            
        }
        keywordTableView.reloadData()
        
    }
    
    
    func setKeywordListFooter(){
        for object in footer.subviews{
            object.removeFromSuperview()
        }
        
        plusButton = UIButton(frame: CGRect(x: 0, y: 0, width: footer.frame.height/2, height: footer.frame.height/2))
        plusButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        plusButton.center = CGPoint(x: footer.frame.width / 2, y:plusButton.frame.height)
        plusButton.tintColor = UIColor.mainOrange
        plusButton.addTarget(self, action: #selector(addUserKeyword), for: .touchUpInside)
        
        footer.addSubview(plusButton)
        
    }
    
    @objc func addUserKeyword(){
        let dvc = keywordStoryboard.instantiateViewController(identifier: "KeywordSettingVCNavigation")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }
    
}

extension MypageVC: menuAlertDelegate{
    func alertKeywordMenu(_ cell: UserKeywordTVC, keyword: String) {
        let actionsheetController = UIAlertController(title: nil, message: "이 키워드의 상태 변경", preferredStyle: UIAlertController.Style.actionSheet)
        
        let definitionAction = UIAlertAction(title: "키워드 정의/수정", style: .default, handler: {
            (action) in
            print("키워드 정의/수정")
        })
        
        let registerAction = UIAlertAction(title: "기록키워드 등록", style: .default, handler: {
            (action) in
            print("기록키워드 등록")
        })
       
        let deleteAction = UIAlertAction(title: "키워드 삭제", style: .destructive , handler: {
            (action) in
            print("키워드 삭제")
        })
       
        let cancelAction = UIAlertAction(title: "닫기(취소)", style: .cancel, handler: {
            (action) in
            print("닫기(취소)")
        })
       

        actionsheetController.addAction(definitionAction)
        
        print(cell.keywordLabel)
        
        if cell.isSelectedKeyword == false {
            actionsheetController.addAction(registerAction)
        }
        
        actionsheetController.addAction(deleteAction)
        actionsheetController.addAction(cancelAction)
        
        
        present(actionsheetController, animated: true, completion: nil)
    }
    
}

//MARK: UI
extension MypageVC{
    func setDelegate(){
        keywordTableView.dataSource = self
        keywordTableView.delegate = self
        keywordTableView.register(UINib(nibName: "RecordKeywordTVC", bundle: .main), forCellReuseIdentifier: RecordKeywordTVC.identifier)
        keywordTableView.register(UINib(nibName: "UserKeywordTVC", bundle: .main), forCellReuseIdentifier: UserKeywordTVC.identifier)
        keywordTableView.isScrollEnabled = false
        
    }
    
    
    func setTitleLabel(){
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        titleLabel.text = "\(userName)님의"
    }
    
    func setButton(){
        
        recordKeywordButton.setTitleColor(UIColor.mainOrange, for: .normal)
        userKeywordButton.setTitleColor(UIColor.mainGray, for: .normal)
        userKeywordBarView.isHidden = true
    }
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.mainOrange
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
      
        navigationItem.title = "마이페이지"
        let settingItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToMypageSetting))
        navigationItem.rightBarButtonItem = settingItem
    }
    
    @objc func goToMypageSetting(){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "MypageSettingVC") as? MypageSettingVC else {
            return
        }
        
        self.present(dvc, animated: true, completion: nil)
        
    }
   
}

