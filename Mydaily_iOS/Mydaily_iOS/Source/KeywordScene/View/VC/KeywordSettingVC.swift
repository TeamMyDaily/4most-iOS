//
//  KeywordSettingVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2020/12/31.
//

import UIKit

class KeywordSettingVC: UIViewController {

    @IBOutlet var KeywordTableView: UITableView!
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var completeButton: UIButton!
    var attitudeOfLife: Array<String> = ["진정성", "용기", "열정", "꾸준함", "배움", "선한영향력", "아웃풋", "행복", "즐거움", "현명", "타당성", "정당성"]
    
    var attitudeOfWork: [String] = ["친절함", "경청", "대충", "진실성", "존중", "신뢰", "의심", "신속성", "돈"]
    
    let originButtonColor: UIColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    
    var selectedKeywordCount = 0
    var selectedKeywordList:[[String]] = []
  
    //User Keyword 부분 관련
    var userKeywordList:[String] = []
    var userKeywordTitleLabel = UILabel()
    var footer = UIView()
    var keywordPlusButton = UIButton()
    var KeywordEditButton = UIButton()
    var contentX = 17
    var contentY = 35
    var checkKeyword = false
    var isKeywordEditing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMainLabelText()
        setDelegate()
        setCompleteButton()
        setTableFooterView()
        initializeMyKeywordList()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        if userKeywordList.count > 0 && checkKeyword{
            addUserKeyword()
        }
        checkKeyword = false
    }
    
    func initializeMyKeywordList(){
        for _ in 0...2{
            var list: [String] = []
            selectedKeywordList.append(list)
        }
    }
    
    @IBAction func submitKeyword(_ sender: Any) {

        guard let dvc = self.storyboard?.instantiateViewController(identifier: NextKeywordVC.identifier) as? NextKeywordVC else{
            return
        }
        
        dvc.setReceivedKeywordList(list: selectedKeywordList)
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func setNavigationBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "키워드 설정하기"
        let questionItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle.fill"), style: .plain, target: self, action: #selector(goKeywordPopUp))
            
        navigationItem.rightBarButtonItem = questionItem
        
    }
    
    @objc func goKeywordPopUp(){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "KeywordPopUpVC") else {
            return
        }
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }

    func setMainLabelText(){
        mainLabel.numberOfLines = 0
        mainLabel.text = "살면서 중요하게\n생각하는 것은 무엇인가요?"
    }
    
    func setCompleteButton(){
        completeButton.setTitle("선택완료!", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.titleLabel?.font =  UIFont(name: "System-Bold", size: 18.0)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    func setDelegate(){
        KeywordTableView.dataSource = self
        KeywordTableView.delegate = self
        KeywordTableView.register(UINib(nibName: "KeywordTableViewCell", bundle: .main), forCellReuseIdentifier: KeywordTableViewCell.identifier)
        KeywordTableView.separatorStyle = .none
    }
 
    
    func print2DKeyword(){
        
        print("현재 선택한 2차원 keyword list")
        
        for txt in selectedKeywordList[0]{
            print("삶 : \(txt)")
        }
        
        for txt in selectedKeywordList[1]{
            print("일 : \(txt)")
        }
        
        for txt in selectedKeywordList[2]{
            print("user 추가 : \(txt)")
        }
        
        print("--------------------------")
    }
    
    
    
    func setButtonActive(){
        if selectedKeywordCount == 8 {
            print("8개 눌림!!! 버튼 활성화")
            completeButton.backgroundColor = .systemOrange
            completeButton.isEnabled = true
        }else{
            completeButton.backgroundColor = originButtonColor
            completeButton.isEnabled = false
        }
    }
    
    
    func printUserAddKeyword(){
        for txt in userKeywordList{
            print("추가한 keyword : \(txt)")
        }
    }
    
}


extension KeywordSettingVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordTableViewCell.identifier) as? KeywordTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cellDelegate = self
        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background
            
        let startIndex = (indexPath.row)*4
        var endIndex = (indexPath.row)*4 + 3
        
        if indexPath.section == 0 {
            let subList: [String] = Array(attitudeOfLife[startIndex...endIndex])
            cell.setKeywordButton(text: subList)
           
        } else if indexPath.section == 1{
            
            if indexPath.row == 1{
                endIndex += 1
            }
            
            let subList: [String] = Array(attitudeOfWork[startIndex...endIndex])
            cell.setKeywordButton(text: subList)
           
        }
        else{
            
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
}

extension KeywordSettingVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        
        header.backgroundColor = .clear
        
        let sectionTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        
        var title: String = ""
        
        if(section == 0){
            title = "삷을 대하는 자세"
        }
        if (section == 1){
            title = "일을 대하는 자세"
        }
        
        sectionTitleLabel.text = title
        
        sectionTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        header.addSubview(sectionTitleLabel)
        
        //top autolayout지정
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
               
        sectionTitleLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 17).isActive = true
        //sectionTitleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
               
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        footer.backgroundColor = .clear
        
        return footer
    }
    
    
    //내가 추가한 키워드는 table footer로
    func setTableFooterView(){
        //let footerHeight = CGFloat(contentY+30)
        footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        //footer.backgroundColor = .systemRed
        
        userKeywordTitleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.size.width - 150, height: 30))
        userKeywordTitleLabel.text = "찾고 있는 가치(단어)가 없으세요?"
        userKeywordTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        
        keywordPlusButton = UIButton(frame: CGRect(x: 16, y: 35, width: 32, height: 32))
        keywordPlusButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        keywordPlusButton.tintColor = originButtonColor
        keywordPlusButton.addTarget(self, action: #selector(goToAddUserKeyword), for: .touchUpInside)
        
        KeywordEditButton = UIButton(frame: CGRect(x: view.frame.size.width - 70 , y: 0, width: 50, height: 30))
        
        KeywordEditButton.setTitle("", for: .normal)
        KeywordEditButton.setTitleColor(.blue, for: .normal)
        KeywordEditButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        
        //KeywordEditButton.backgroundColor = .red
        
        
        footer.addSubview(userKeywordTitleLabel)
        footer.addSubview(keywordPlusButton)
        footer.addSubview(KeywordEditButton)
        
        print(KeywordTableView.frame.height - 60)
        //오토레이아웃을 코드로 지정 할 때 사용
        
//       // keywordPlusButton.translatesAutoresizingMaskIntoConstraints = false
//
//        keywordPlusButton.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 17).isActive = true
//        //completeButton.rightAnchor.constraint(equalTo: footer.rightAnchor, constant: -22).isActive = true
//        keywordPlusButton.topAnchor.constraint(equalTo: footer.topAnchor, constant: 40).isActive = true
//        //completeButton.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: 0).isActive = true
//
        KeywordTableView.tableFooterView = footer
    }
    
    @objc func goToAddUserKeyword(){
        guard let dvc = self.storyboard?.instantiateViewController(identifier: AddUserKeywordVC.identifier) else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func checkForUserKeyword(check: Bool){
        checkKeyword = check
    }
    
    func addUserKeyword(){
        
        //title label 바꾸기
    
        if userKeywordList.count > 0{
            userKeywordTitleLabel.text = "내가 추가한 키워드"
            userKeywordTitleLabel.textColor = .orange
            userKeywordTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
            
            KeywordEditButton.setTitle("수정", for: .normal)
        }
        
        let lastIndex = userKeywordList.count - 1
        
        let KeywordText = userKeywordList[lastIndex]
        
        let buttonWidth = KeywordText.count * 17 + 24
        
        let myKeywordButton = UIButton(frame: CGRect(x: contentX, y: contentY, width: buttonWidth, height: 32))
        contentX += buttonWidth + 8
        myKeywordButton.titleEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 5, right: 12)
        myKeywordButton.setTitle(KeywordText, for: .normal)
        myKeywordButton.setTitleColor(.white, for: .normal)
        myKeywordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        myKeywordButton.layer.cornerRadius = 15
        myKeywordButton.backgroundColor = originButtonColor
        myKeywordButton.contentVerticalAlignment = .center
        
        
        myKeywordButton.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        
        myKeywordButton.imageView?.isHidden = true
        myKeywordButton.semanticContentAttribute = .forceRightToLeft
//        myKeywordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
//
        
        myKeywordButton.tintColor = .white
        
        myKeywordButton.addTarget(self, action: #selector(selectedUserKeyword), for: .touchUpInside)
        
        print("-----")
        //print(myKeywordButton.imageView)
        //footer.addSubview(myKeywordButton.imageView!)
        if userKeywordList.count % 2 == 1 {
            myKeywordButton.imageView?.isHidden = true
        }
        
        let systemSize = Int(view.frame.size.width)

        if contentX > systemSize - 100 {
            contentX = 17
            contentY += 48
            
            keywordPlusButton.frame.origin.y = CGFloat(contentY)
        }
        
        footer.addSubview(myKeywordButton)
        keywordPlusButton.frame.origin.x = CGFloat(contentX)
            
        
       // myKeywordButton.sizeThatFits(CGSize(width: buttonWidth, height: 32))
//        myKeywordButton.translatesAutoresizingMaskIntoConstraints = false
//
//        myKeywordButton.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 17).isActive = true
//        //completeButton.rightAnchor.constraint(equalTo: footer.rightAnchor, constant: -22).isActive = true
//        myKeywordButton.topAnchor.constraint(equalTo: footer.topAnchor, constant: 40).isActive = true
//        //completeButton.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: 0).isActive = true
//
        //keywordPlusButton.leftAnchor.constraint(equalTo: myKeywordButton.rightAnchor, constant: 8).isActive = true
        
        //footer.addSubview(myKeywordButton)
       // myKeywordButton.frame.width
    }
    
    @objc func selectedUserKeyword(_ sender: UIButton){
        print("user버튼 눌림")
        let selectedText = sender.titleLabel?.text ?? ""
        
        if selectedKeywordCount < 8 {
            if sender.backgroundColor == originButtonColor{
                addSelectedUserKeyword(text: selectedText)
                sender.backgroundColor = .orange
            }else{
                cancelSelectedUserKeyword(text: selectedText)
                sender.backgroundColor = originButtonColor
            }
            
        }else if selectedKeywordCount == 8 && sender.backgroundColor != originButtonColor{
            cancelSelectedUserKeyword(text: selectedText)
            sender.backgroundColor = originButtonColor
            
        }else{
            alertKeyword()
        }
        
        setButtonActive()
    }
    
    
    func addSelectedUserKeyword(text: String){
        selectedKeywordList[2].append(text)
        print2DKeyword()
        selectedKeywordCount += 1
    }
    
    func cancelSelectedUserKeyword(text: String){
        let index = selectedKeywordList[2].firstIndex(of: text) ?? 0
        selectedKeywordList[2].remove(at: index)
        selectedKeywordCount -= 1
    }
    
    
    func addUserKeyword(text :String){
        userKeywordList.append(text)
        print("------현재 userKeywordList------")
        
        for txt in userKeywordList {
            print(txt)
        }
    }
    
}

extension KeywordSettingVC: SelectKeywordDelegate{
    
    func addSelectedKeyword(_ cell: KeywordTableViewCell, selectedText: String) -> Bool{
        if selectedKeywordCount >= 8{
            alertKeyword()
            return false
        }else{
            if attitudeOfWork.contains(selectedText){
                selectedKeywordList[1].append(selectedText)
            }else{
                selectedKeywordList[0].append(selectedText)
            }
            
            print2DKeyword()
           //selectedKeyword.append(selectedText)
            //printKeyword()
            selectedKeywordCount += 1
            setButtonActive()
            return true
        }
    }
    
    func removeSelectedKeyword(_ cell: KeywordTableViewCell, selectedText: String) {
        
        var keywordIndex = -1
        
        for i in 0...2{
            keywordIndex = selectedKeywordList[i].firstIndex(of: selectedText) ?? -1
            
            if keywordIndex != -1{
                selectedKeywordList[i].remove(at: keywordIndex)
                selectedKeywordCount -= 1
                setButtonActive()
            }
        }
        
        print("\(selectedText) 삭제됨")
        print2DKeyword()
      
    }
    
    func alertKeyword(){
        let txt = "키워드를 많이 선택 하셨어요.\n키워드는 8개 까지 선택이 가능합니다.\n좀 더 고민해서 하나를 제외 해 주세요!"
        let alert = UIAlertController(title: "8개까지 선택 가능해요!", message: txt, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
       
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
}


/*collectionView로 할 경우
extension KeywordSettingVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordTVC.identifier) as? KeywordTVC else {
            return UITableViewCell()
        }
        
        
        if indexPath.section == 0 {
            cell.setKeywordList(list: attitudeOfLife)
        } else if indexPath.section == 1{
            cell.setKeywordList(list: attitudeOfWork)
        }
        else{
            cell.setKeywordList(list: addKeywordList)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "삷을 대하는 자세"
        }
        else if (section == 1){
            return "일을 대하는 자세"
        }
        else{
            return "내가 추가한 키워드"
        }
    }
}
*/

