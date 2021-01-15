//
//  DailyVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit
import Moya

class DailyVC: UIViewController, ThreePartCellDelegate {
    
    private let authProvider = MoyaProvider<DailyService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var dailyModel: DailyModel?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var userDaily: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyImg: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var myArray = [String]()
    var currentDate = Date()
    var since1970: Double?
    var str = ""
    var toto = false
    
    let dateButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.setTitle("오늘", for: .normal)
        $0.setImage(UIImage(named: "btn_today"), for: .normal)
        $0.layer.cornerRadius = 20
        $0.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(setToday), for: .allTouchEvents)
        return $0
    }(UIButton(frame: .zero))
    
    override func viewWillAppear(_ animated: Bool) {
        print(Int(Date().timeIntervalSince1970 * 1000))
        getDaily()
        setupNavigationBar(.clear, titlelabel: "")
    }
    
    override func viewDidLoad() {
        toto = true
        super.viewDidLoad()
        setTableVC()
        floatingButton()
        setUI()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func moreTapped(cell: DetailTVC) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
   
    @IBAction func changedDate(_ sender: Any) {
        setDate()

        print("djd")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 W주"
        getDaily()
        setEmpty()
    }

}

//MARK: - UI
extension DailyVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    func setUI() {
        headerView.layer.addBorder([.top,.bottom], color: UIColor.gray30, width: 1.0, move: 0)
        datePicker.maximumDate = Date()
        setDate()
        //서벼연결시 변경 부분
        let username = UserDefaultStorage.userName
        userDaily.text = "\(username ?? "")님의 하루 기록"
        userDaily.font = .myMediumSystemFont(ofSize: 15)
        userDaily.textColor = UIColor.mainBlack
        
        dateLabel.font = .myMediumSystemFont(ofSize: 12)
        setEmpty()
    }
    
    func setEmpty(){
        if dailyModel?.data?.keywordsExist == false{
            tableView.backgroundColor = .white
            tableView.separatorStyle = .none
            emptyImg.isHidden = false
            emptyImg.image = UIImage(named: "image_rest")
            emptyLabel.text = "이 날에는 기록이 없어요.😢"
            emptyLabel.font = .myRegularSystemFont(ofSize: 12)
            emptyLabel.textColor = .lightGray
        }else{
            tableView.separatorStyle = .singleLine
            tableView.separatorInset.right = 16
            tableView.separatorInset.left = 16
            emptyImg.image = UIImage(named: "image_rest")
            emptyImg.isHidden = true
            emptyLabel.text = ""
        }
    }
    func setDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        if dateLabel.text != dateFormatter.string(from: Date()){
            dateLabel.textColor = .mainGray
            dateButton.fadeTransition()
            dateButton.layer.opacity = 100
        }
        else{
            dateLabel.textColor = .mainOrange
            dateButton.fadeTransition()
            dateButton.layer.opacity = 0
        }
    }
    
    func floatingButton(){
        
        self.tableView.addSubview(dateButton)
        
        NSLayoutConstraint.activate([
            dateButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            dateButton.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            dateButton.widthAnchor.constraint(equalToConstant: 66),
            dateButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func setToday(sender: UIButton!) {
        datePicker.date = Date()
        setDate()
        setEmpty()
        getDaily()
    }
    
    func DateInMilliSeconds()-> Int
    {
        if datePicker.date == Date(){
            return Int(Date().timeIntervalSince1970 * 1000)
        }
        else{
            currentDate = self.datePicker.date
        }
        since1970 = currentDate.timeIntervalSince1970
        
        return Int(since1970! * 1000)
    }
}

extension DailyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dailyModel?.data?.keywordsExist == true {
            return (self.dailyModel?.data?.result?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "DailyWriteVC") as? DailyWriteVC else {return}
        VC.keywordID = self.dailyModel?.data?.result![indexPath.row]?.totalKeywordID
        VC.taskTitle = self.dailyModel?.data?.result![indexPath.row]?.name
        
        if self.dailyModel?.data?.result![indexPath.row]?.tasks.count != 0{
            VC.taskID = self.dailyModel?.data?.result![indexPath.row]?.tasks[0]?.id
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTVC.reuseIdentifier, for: indexPath) as! DetailTVC

        cell.selectionStyle = .none
        
        myArray = []
        for outterIndex in 0...(self.dailyModel?.data?.result?.count)! - 1 {
            str = ""
            for i in 0..<(dailyModel?.data?.result![outterIndex]?.tasks.count)! {
                str += "\(String(describing: dailyModel?.data?.result![outterIndex]?.tasks[i]?.title ?? ""))\n"
            }
            
            myArray.append(str)
        }
        str = myArray[indexPath.row]

        cell.taskID = dailyModel?.data?.result![indexPath.row]?.totalKeywordID
        cell.labelBody?.textColor = .white
        cell.numImg.image = UIImage(named: "image\(indexPath.row + 1)")
//        cell.numImg.curre
        cell.labelSubTitle.text = "\(dailyModel?.data?.result![indexPath.row]?.tasks.count ?? 0)개의 기록이 당신을 기다리고 있어요."
        cell.myInit(theTitle: " \((dailyModel?.data?.result![indexPath.row]?.name) ?? "")", theBody: str)
       
        let attributedString = NSMutableAttributedString(string: cell.labelSubTitle.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainOrange, range: (cell.labelSubTitle.text! as NSString).range(of:"\(dailyModel?.data?.result![indexPath.row]?.tasks.count ?? 0)개의 기록"))
        cell.labelSubTitle.attributedText = attributedString
        
        
        cell.delegate = self
        
        return cell
    }
}

extension DailyVC {
    func setTableVC(){
        tableView.delegate = self
        tableView.dataSource = self
        let containNibname = UINib(nibName: DetailTVC.nibName, bundle: nil)
        tableView.register(containNibname, forCellReuseIdentifier: DetailTVC.reuseIdentifier)
        
        tableView.estimatedRowHeight = 108;
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset.right = 16
        tableView.separatorInset.left = 16
    }
}

extension DailyVC {
    func getDaily(){
        let UTCDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT:0)
        let defaultTimeZoneStr = formatter.string(from: UTCDate)
        let today = formatter.string(from: datePicker.date)
        
        var param: DailyRequest?
        
        if today == defaultTimeZoneStr {
            
            param = DailyRequest.init("\(Int(Date().timeIntervalSince1970 * 1000))")
        }else{
            print("&\(datePicker.date)")
            param = DailyRequest.init("\(DateInMilliSeconds())")
        }
        authProvider.request(.dailyinquiry(param: param!)) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(DailyModel.self)
                        self.dailyModel = data
                        self.tableView.reloadData()
                        self.setEmpty()
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
