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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMainLabelText()
        setDelegate()
        setCompleteButton()
        setTableFooterView()
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
    
    @IBAction func goKeywordPopUp(){
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
    
    func setButtonActive(){
        if selectedKeyword.count == 8 {
            print("8개 눌림!!! 버튼 활성화")
            completeButton.backgroundColor = .systemOrange
            completeButton.isEnabled = true
        }else{
            completeButton.backgroundColor = originButtonColor
            completeButton.isEnabled = false
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
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 160))
        //footer.backgroundColor = .systemRed
        
        let titleLabel = UILabel(frame: CGRect(x: 17, y: 0, width: view.frame.size.width, height: 30))
        titleLabel.text = "찾고 있는 가치(단어)가 없으세요?"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        
        let completeButton = UIButton(frame: CGRect(x: 17, y: 30, width: 32, height: 32))
        completeButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        completeButton.tintColor = originButtonColor
        completeButton.backgroundColor = .blue
        
        
        footer.addSubview(titleLabel)
        footer.addSubview(completeButton)
        
        print(KeywordTableView.frame.height - 60)
        //오토레이아웃을 코드로 지정 할 때 사용
        /*
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        completeButton.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 25).isActive = true
        completeButton.rightAnchor.constraint(equalTo: footer.rightAnchor, constant: -22).isActive = true
        completeButton.topAnchor.constraint(equalTo: footer.topAnchor, constant: 0).isActive = true
        completeButton.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: 0).isActive = true
        */
        KeywordTableView.tableFooterView = footer
    }
    

}

extension KeywordSettingVC: SelectKeywordDelegate{
    
    func addSelectedKeyword(_ cell: KeywordTableViewCell, selectedText: String) {
        selectedKeyword.append(selectedText)
        printKeyword()
        setButtonActive()
        
    }
    
    func removeSelectedKeyword(_ cell: KeywordTableViewCell, selectedText: String) {
        let keywordIndex = selectedKeyword.firstIndex(of: selectedText)
        if keywordIndex != nil {
            selectedKeyword.remove(at: keywordIndex ?? 0)
            //selectedKeywordCount -= 1
            
            setButtonActive()
        }
        
        printKeyword()
        
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

