//
//  MypageVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit
import Moya

class MypageVC: UIViewController {

    static let identifier = "MypageVC"
    private let mypageAuthProvider = MoyaProvider<MypageService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private let keywordAuthProvider = MoyaProvider<KeywordServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    //var responseToken: MypageRecordKeywordModel?
    
    @IBOutlet weak var keywordSettingButton: UIButton!
    @IBOutlet var keywordTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    
    var recordKeywordList: [RecordKeywordData] = []
    var priorityKeywordList: [PriorityKeyword] = []
    var userKeywordList: [SelectedUserKeyword] = []
    //var userKeywordList2: [String] = ["선한영향력", "경청", "친절함", "대충", "열정" ,"진실성", "존중", "신뢰","연어덮밥"]
    var pageNumber = 0
    let username = UserDefaultStorage.userName
    
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
    var registerPermission = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setButton()
        setupStatusBar(UIColor.mainOrange)
        setNavigationBar()
        setInitTableFooterView()
        
    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
//        getRecordKeywords()
//        getUserKeywords()
//        setTitleLabel()
//        registerPermission = checkRegisterPermission()
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        getRecordKeywords()
        getUserKeywords()
        setTitleLabel()
        registerPermission = checkRegisterPermission()
    }
    
    func checkRegisterPermission() -> Bool{
        var checkCount = 0
        for list in userKeywordList{
            print("\(list.name) \(list.isSelected)")
            if list.isSelected{
                checkCount += 1
            }
            
            if checkCount >= 4{
                return false
            }
        }
        return true
    }
    
    @IBAction func goToSettingKeywordView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Keyword", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "KeywordSettingVCNavigation")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)

    }
    
    @IBAction func touchUpRecordKeyword(_ sender: UIButton){
        if sender.title(for:.normal) == "기록키워드"{
            getRecordKeywords()
            pageNumber = 0
            recordKeywordButton.setTitleColor(UIColor.mainOrange, for: .normal)
            userKeywordButton.setTitleColor(UIColor.mainGray, for: .normal)
            recordKeywordBarView.isHidden = false
            userKeywordBarView.isHidden = true
            keywordTableView.isScrollEnabled = false
            setRecordFooter()
            deleteHeaderView()
        }else{
            getUserKeywords()
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
    }
}

extension MypageVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageNumber == 0{
            print("page 기록 : \(recordKeywordList.count)")
            return recordKeywordList.count
        }else{
            print("page 전체 : \(userKeywordList.count)")
            return userKeywordList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if pageNumber == 0{
            if indexPath.row > 4{
                return UITableViewCell()
            }
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "RecordKeywordTVC") as! RecordKeywordTVC
            
            
            print("recordKeywordList count = \(recordKeywordList.count)")
            print("table view = \(indexPath.row)")
            print("table view = \(recordKeywordList[indexPath.row].name)")
           
            let keywordName = recordKeywordList[indexPath.row].name
            let ranking = indexPath.row+1
            
            recordCell.setContent(rank: ranking, keyword: keywordName)
            
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
            
            recordCell.selectionStyle = .none
            
            return recordCell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserKeywordTVC") as? UserKeywordTVC else{
                return UITableViewCell()
            }
            cell.cellDelegate = self
            
            let userKeyword:SelectedUserKeyword = userKeywordList[indexPath.row]
            
            cell.setContent(selected: userKeyword.isSelected, keyword: userKeyword.name)
            //cell.setContent(selected: isSelectedKeyword, keyword: userKeywordList[indexPath.row])
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pageNumber == 0{
            //선택된 키워드 정의 조회
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
        recordKeywordList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    func setHeaderView(){
        header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let listDescription = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let username = UserDefaultStorage.userName
        listDescription.text = "\(username)님이 추구하는 가치관이에요!"
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
            sender.center =  CGPoint(x: footer.frame.width / 2 , y: 80)
            sender.backgroundColor = .mainOrange
            
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
            
            priorityKeywordList = []
            
            for i in 0..<recordKeywordList.count{
                priorityKeywordList.append(PriorityKeyword(name: recordKeywordList[i].name, priority: i+1))
            }
            modifyKeywordPriority()
        }
        keywordTableView.reloadData()
        
    }
    
    
    func setKeywordListFooter(){
        for object in footer.subviews{
            object.removeFromSuperview()
        }
        
        plusButton = UIButton(frame: CGRect(x: 0, y: 0, width: footer.frame.height/2, height: footer.frame.height/2))
        plusButton.setBackgroundImage(UIImage(named: "btn_add"), for: .normal)
        
        plusButton.center = CGPoint(x: footer.frame.width / 2, y:plusButton.frame.height)
        plusButton.tintColor = UIColor.mainOrange
        plusButton.addTarget(self, action: #selector(addUserKeyword), for: .touchUpInside)
        
        footer.addSubview(plusButton)
        
    }
    
    @objc func addUserKeyword(){
        print("키워드 추가하기로 넘어감")
        let dvc = keywordStoryboard.instantiateViewController(identifier: "AddUserKeywordVC") as! AddUserKeywordVC
        dvc.isFirstSettingPage(check: false)
        self.navigationController?.pushViewController(dvc, animated: true)
        getUserKeywords()
    }
    
}

extension MypageVC: menuAlertDelegate{
    func alertKeywordMenu(_ cell: UserKeywordTVC, keyword: String) {
        
        print("!!!!!!!!!!!!!!!!\(cell.keywordLabel.text!)")
        print("!!!!!!!!!!!!!!!!\(cell.isSelectedKeyword)")
        registerPermission = checkRegisterPermission()
        print("등록가능한가요? \(registerPermission)")
        let cellLabel = cell.keywordLabel.text ?? ""
        var cellSelected = false
        var cellKeywordId = -1
        
        for i in 0..<userKeywordList.count{
            print("\(userKeywordList[i].name) , \(userKeywordList[i].isSelected)")
            if userKeywordList[i].name == cellLabel{
                cellSelected = userKeywordList[i].isSelected
                cellKeywordId = userKeywordList[i].totalKeywordId
                break
            }
        }
        
        let actionsheetController = UIAlertController(title: nil, message: "이 키워드의 상태 변경", preferredStyle: UIAlertController.Style.actionSheet)
        
        let definitionAction = UIAlertAction(title: "키워드 정의/수정", style: .default, handler: {
            (action) in
            print("키워드 정의/수정")
            self.getKeywordDefinition(keywordId: cellKeywordId, keyword: cellLabel)
            
        })
        
        let registetAction = UIAlertAction(title: "기록키워드 등록", style: .default, handler: {
            (action) in
            print("기록키워드 등록")
            print("서버로 기록 키워드 등록하러감")
            self.postRegisterKeyword(keywordId: cellKeywordId, keywordName: cellLabel)
        })
        
        let unRegistetAction = UIAlertAction(title: "기록키워드 해제", style: .default, handler: {
            (action) in
            print("기록키워드 해제")
            
            let txt = "이 키워드를 등록 해제 하면 앞으로\n기록과 목표에서 볼 수없어요.\n이후에 다시 키워드를 이용하고 싶다면\nMY> 키워드 목록> 키워드 등록에서\n 키워드를 재등록 해 주세요."
            let alert = UIAlertController(title: "키워드를 등록 해제 하시겠어요?", message: txt, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인했어요", style: .default) { (action) in
                
                self.deleteResigsterKeyword(keywordId: cellKeywordId, keywordName: cellLabel)
                // self.deleteUserKeyword(KeywordId: cellKeywordId, deleteKeyword: cellLabel)
               
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        })
       
        
        let deleteAction = UIAlertAction(title: "키워드 삭제", style: .destructive , handler: {
            (action) in
            print("키워드 삭제 완료")
            
            let txt = "이 키워드를 삭제하면 작성하셨던\n정의, 기록, 목표가 모두 사라져요.\n그래도 정말 삭제하시겠어요?"
            let alert = UIAlertController(title: "키워드를 삭제 하시겠어요?", message: txt, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                
                self.deleteUserKeyword(KeywordId: cellKeywordId, deleteKeyword: cellLabel)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel){ (action) in }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
           
        })
       
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
            (action) in
            print("취소")
        })
       
        actionsheetController.addAction(definitionAction)
        
        if cellSelected{
            actionsheetController.addAction(unRegistetAction)
        }else{
            if registerPermission{
                actionsheetController.addAction(registetAction)
            }
        }
        
        actionsheetController.addAction(deleteAction)
        actionsheetController.addAction(cancelAction)
        
        present(actionsheetController, animated: true, completion: nil)
    }
    
    func printKeywordList(){
        for i in 0..<userKeywordList.count{
            print(userKeywordList[i])
        }
        
        for i in 0..<recordKeywordList.count{
            print(recordKeywordList[i])
        }
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
        let username = UserDefaultStorage.userName
        titleLabel.text = "\(username)님의"
        titleLabel.font = UIFont.myBlackSystemFont(ofSize: 25)
    }
    
    func setButton(){
        recordKeywordButton.setTitleColor(UIColor.mainOrange, for: .normal)
        userKeywordButton.setTitleColor(UIColor.mainGray, for: .normal)
        recordKeywordButton.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 16)
        userKeywordButton.titleLabel?.font = UIFont.myMediumSystemFont(ofSize: 16)
        userKeywordBarView.isHidden = true
    }
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.mainOrange
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
      
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.title = "마이페이지"
        //navigationBar.tintColor = .white
        let settingItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToMypageSetting))
        settingItem.tintColor = .white
        navigationItem.rightBarButtonItem = settingItem
    }
    
    @objc func goToMypageSetting(){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "MypageSettingVC") as? MypageSettingVC else {
            return
        }
        
        navigationController?.pushViewController(dvc, animated: true)
    }
    
}


//네트워크
extension MypageVC{
    func getRecordKeywords(){
        print("getRecordKeywords")
        mypageAuthProvider.request(.userRecordKeywords){ [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    do {
                        let data = try response.map(MypageRecordKeywordModel.self)
                        self.recordKeywordList = []
                        self.recordKeywordList = data.data.keywords
                        self.keywordTableView.reloadData()
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func getUserKeywords(){
        print("getUserKeywords")
        mypageAuthProvider.request(.userKeywordList){ [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        do {
                            let responseToken = try response.map(MypageKeywordListModel.self)
                            self.userKeywordList = []
                            self.userKeywordList = responseToken.data
                            self.registerPermission = self.checkRegisterPermission()
                            self.keywordTableView.reloadData()
                        } catch(let err) {
                            print(err.localizedDescription)
                        }
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func modifyKeywordPriority(){
        print("modifyKeywordPriority")
        let param = PriorityKeywordRequest(list: priorityKeywordList)
        keywordAuthProvider.request(.priorityKeyword(param: param)){ responds in
            switch responds {
            case .success(let result):
                do {
                    print("와이라노 \(result.statusCode)")
                    let token = try result.map(PriorityKeywordModel.self)
                    print("우선순위 변경 완료")
                    self.keywordTableView.reloadData()
                } catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func postRegisterKeyword(keywordId: Int, keywordName: String){
        print("postRegisterKeyword")
        let param = RegisterRecordKeywordRequest(totalKeywordId: keywordId)
        mypageAuthProvider.request(.registerRecordKeywords(param: param)){ responds in
            switch responds {
            case.success(let result):
                do{
                    let token = try result.map(RegisterRecordKeywordModel.self)
                    print(token.message)
                    self.getUserKeywords()
                }catch(let err){
                    if result.statusCode == 200{
                        self.getRecordKeywords()
                        self.getUserKeywords()
                        print(err.localizedDescription)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func deleteResigsterKeyword(keywordId:Int , keywordName: String){
        print("deleteResigsterKeyword")
        let param = KeywordIdRequest(totalKeywordId: keywordId)
        mypageAuthProvider.request(.deleteRegisterKeyword(param: param)){ responds in
            switch responds {
            case .success(let result):
                DispatchQueue.main.async {
                    do{
                        let token = try result.map(BasicResponseModel.self)
                        print("delete : \(token.message)")
                        self.getUserKeywords()
                        self.keywordTableView.reloadData()
                   
                    }catch(let err){
                        print(err.localizedDescription)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    
    func deleteUserKeyword(KeywordId: Int, deleteKeyword: String){
        print("deleteUserKeyword")
        let param = KeywordIdRequest(totalKeywordId: KeywordId)
        mypageAuthProvider.request(.deleteKeyword(param: param)){ responds in
            switch responds {
            case .success(let result):
                DispatchQueue.main.async {
                    do{
                        let token = try result.map(BasicResponseModel.self)
                        print("delete : \(token.message)")
                        self.getUserKeywords()
                        self.keywordTableView.reloadData()
                    }catch(let err){
                        print(err.localizedDescription)
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    func getKeywordDefinition(keywordId: Int , keyword: String){
        print("getKeywordDefinition")
        let param = KeywordIdRequest(totalKeywordId: keywordId)
        mypageAuthProvider.request(.getKeywordDefinition(param: param)){ response in
            switch response {
                case .success(let result):
                    do {
                        let responseObject = try result.map(KeywordDefinitionModel.self)
                        var keywordDefinition = ""
                        if responseObject.data.isWritten{
                            keywordDefinition = responseObject.data.definition
                        }
                        
                        print("누른거 : \(keyword) , 서버에서 가져온 것 \(keyword)")
                        
                        let dvc = self.keywordStoryboard.instantiateViewController(identifier: KeywordDefineVC.identifier) as! KeywordDefineVC
                        dvc.setKeywordAndDefinition(key: keyword, value: keywordDefinition)
                        self.navigationController?.pushViewController(dvc, animated: true)
                        
                        } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
        
    }
}


