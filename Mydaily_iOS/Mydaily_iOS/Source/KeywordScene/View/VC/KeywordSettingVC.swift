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
    
   // var addKeywordList: [String] = []
    
    static var selectedKeywordCount: Int = 0
    static var selectedKeywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMainLabelText()
        setDelegate()
        setCompleteButton()
        
        //setTableFooterView()
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews 호출됨")
        print("\(KeywordSettingVC.selectedKeywordList.count)")
        if KeywordSettingVC.selectedKeywordList.count == 8 {
            print("8개")
            completeButton.backgroundColor = .systemOrange
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear 호출됨")
        if KeywordSettingVC.selectedKeywordList.count == 8 {
            print("8개")
            completeButton.backgroundColor = .systemOrange
        }
        
    }
  
    @IBAction func submitKeyword(_ sender: Any) {
        if KeywordSettingVC.selectedKeywordList.count == 8 {
            print("8개")
            completeButton.backgroundColor = .systemOrange
            completeButton.isEnabled = true
        }
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
        
        if KeywordSettingVC.selectedKeywordList.count == 8 {
            print("8개")
            completeButton.backgroundColor = .systemOrange
            completeButton.isEnabled = true
        }
    }
    
    func setDelegate(){
        KeywordTableView.dataSource = self
        KeywordTableView.delegate = self
        KeywordTableView.register(UINib(nibName: "KeywordTableViewCell", bundle: .main), forCellReuseIdentifier: KeywordTableViewCell.identifier)
        KeywordTableView.separatorStyle = .none
    }
    
    static func addSelectedKeyword(text: String){
        selectedKeywordCount += 1
        selectedKeywordList.append(text)
        printSelectedKeyword()
    }
    
    static func removeSelectedKeyword(text: String){
        let keywordIndex = selectedKeywordList.firstIndex(of: text)
        if keywordIndex != nil {
            selectedKeywordList.remove(at: keywordIndex ?? 0)
            selectedKeywordCount -= 1
        }
        printSelectedKeyword()
    }
    

    static func printSelectedKeyword(){
        
        print("현재 선택한 keyword list")
        for txt in selectedKeywordList{
            print(txt)
        }
        print("--------------------------")
    }
    
}


extension KeywordSettingVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else if section == 1 {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordTableViewCell.identifier) as? KeywordTableViewCell else {
            return UITableViewCell()
        }
        
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
        return 3
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
        else if (section == 1){
            title = "일을 대하는 자세"
        }
        else{
            title = "내가 추가한 키워드"
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt 호출됨 + \(indexPath)")
        if KeywordSettingVC.selectedKeywordList.count == 8 {
            print("8개")
            completeButton.backgroundColor = .systemOrange
            completeButton.isEnabled = true
        }
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

