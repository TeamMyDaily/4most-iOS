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
   
    var selectedKeyword: [String] = []
    
    var selectedKeywordCount = 0
    var selectedKeywordList:[[String]] = []
    var userAddKeywordList:[String] = []
    var userKeywordTitleLabel = UILabel()
    
    var footer = UIView()
    var keywordPlusButton = UIButton()
    var contentX = 17
    var contentY = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMainLabelText()
        setDelegate()
        setCompleteButton()
        setTableFooterView()
        initializeMyKeywordList()
    }
  
    func initializeMyKeywordList(){
        for _ in 0...2{
            var list: [String] = []
            selectedKeywordList.append(list)
        }
    }
    
    @IBAction func submitKeyword(_ sender: Any) {

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
    
    func printKeyword(){
        
        print("현재 선택한 새로운 keyword list")
        for txt in selectedKeyword{
            print(txt)
        }
        print("--------------------------")
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
    
    
    func setButtonActive1(){
        if selectedKeyword.count == 8 {
            print("8개 눌림!!! 버튼 활성화")
            completeButton.backgroundColor = .systemOrange
            completeButton.isEnabled = true
        }else{
            completeButton.backgroundColor = originButtonColor
            completeButton.isEnabled = false
        }
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
        for txt in userAddKeywordList{
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
        footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        //footer.backgroundColor = .systemRed
        
        userKeywordTitleLabel = UILabel(frame: CGRect(x: 17, y: 0, width: view.frame.size.width, height: 30))
        userKeywordTitleLabel.text = "찾고 있는 가치(단어)가 없으세요?"
        userKeywordTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        
        keywordPlusButton = UIButton(frame: CGRect(x: 17, y: 35, width: 32, height: 32))
        
        //keywordPlusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        keywordPlusButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        keywordPlusButton.tintColor = originButtonColor
        //keywordPlusButton.backgroundColor = .brown
        
        keywordPlusButton.addTarget(self, action: #selector(addMyKeyword), for: .touchUpInside)
        
        footer.addSubview(userKeywordTitleLabel)
        footer.addSubview(keywordPlusButton)
        
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
    
    
    @objc func addMyKeyword(){
       
        let KeywordText = "추가"
        let testKeyword = KeywordText + "\(userAddKeywordList.count * 30 )"
        userAddKeywordList.append(testKeyword)
        
        if userAddKeywordList.count != 0{
            userKeywordTitleLabel.text = "내가 추가한 키워드"
            userKeywordTitleLabel.textColor = .orange
            userKeywordTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
            
        }
        
        let buttonWidth = testKeyword.count * 15 + 20
        
        let myKeywordButton = UIButton(frame: CGRect(x: contentX, y: contentY, width: buttonWidth, height: 32))
        contentX += buttonWidth + 8
        //keywordPlusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        myKeywordButton.titleEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 5, right: 12)
        myKeywordButton.setTitle(testKeyword, for: .normal)
        myKeywordButton.setTitleColor(.white, for: .normal)
        myKeywordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        myKeywordButton.layer.cornerRadius = 15
        myKeywordButton.backgroundColor = originButtonColor
        
        myKeywordButton.addTarget(self, action: #selector(selectedUserKeyword), for: .touchUpInside)
        
       // myKeywordButton.sizeThatFits(CGSize(width: buttonWidth, height: 32))
        
        let systemSize = Int(view.frame.size.width)

        if contentX > systemSize - 100 {
            contentX = 17
            contentY += 48
            
            keywordPlusButton.frame.origin.y = CGFloat(contentY)
        }
        
        footer.addSubview(myKeywordButton)
       
//        myKeywordButton.translatesAutoresizingMaskIntoConstraints = false
//
//        myKeywordButton.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 17).isActive = true
//        //completeButton.rightAnchor.constraint(equalTo: footer.rightAnchor, constant: -22).isActive = true
//        myKeywordButton.topAnchor.constraint(equalTo: footer.topAnchor, constant: 40).isActive = true
//        //completeButton.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: 0).isActive = true
//
        //keywordPlusButton.leftAnchor.constraint(equalTo: myKeywordButton.rightAnchor, constant: 8).isActive = true
        keywordPlusButton.frame.origin.x = CGFloat(contentX)
        
        
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
        let alert = UIAlertController(title: "주의", message: "8개만 선택해주세요", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in}
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

