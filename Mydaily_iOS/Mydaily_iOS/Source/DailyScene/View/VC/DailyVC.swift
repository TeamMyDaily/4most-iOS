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
    
    var myArray = [String]()
    
    let dateButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("오늘 >", for: .normal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .mainBlack
        $0.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(setToday), for: .allTouchEvents)
        return $0
    }(UIButton(frame: .zero))
    
    override func viewWillAppear(_ animated: Bool) {
        getDaily()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setTableVC()
        setupNavigationBar(.clear, titlelabel: "")
        floatingButton()
        setUI()
    }
    
    func setDropData(){
        for outterIndex in 0...3 {
            var str = ""
            for i in 0..<(dailyModel?.data.result[outterIndex].tasks.count)! {
                str += "\(String(describing: dailyModel?.data.result[outterIndex].tasks[i]))\n"
            }
            myArray.append(str)
        }
        print(myArray)
        
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

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 W주"
        print("&\(datePicker.date.startOfWeek!)")
        print("&\(datePicker.date.endOfWeek!)")
        print("@\(dateFormatter.string(from: datePicker.date.containWeek!))")
    }
}

//MARK: - UI
extension DailyVC {
    func setUI() {
        headerView.layer.addBorder([.top,.bottom], color: UIColor.gray30, width: 1.0, move: 0)
        datePicker.maximumDate = Date()
        setDate()
        
        logoLabel.font = .myBoldSystemFont(ofSize: 21)
        logoLabel.textColor = UIColor.mainOrange
        logoLabel.sizeToFit()
        logoLabel.text = "4most"
        
        //서벼연결시 변경 부분
        userDaily.text = "이주미님의 하루 기록"
        userDaily.font = .myMediumSystemFont(ofSize: 15)
        userDaily.textColor = UIColor.mainBlack
        
        dateLabel.font = .myMediumSystemFont(ofSize: 12)
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
            dateButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -72),
            dateButton.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            dateButton.widthAnchor.constraint(equalToConstant: 66),
            dateButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func setToday(sender: UIButton!) {
        datePicker.date = Date()
        setDate()
    }
}

extension DailyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dailyModel?.data.keywordsExist == true{
            return 4
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "DailyWriteVC") as? DailyWriteVC else {return}
        VC.taskID = self.dailyModel?.data.result[indexPath.row].priority
        VC.taskTitle = self.dailyModel?.data.result[indexPath.row].name
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTVC.reuseIdentifier, for: indexPath) as! DetailTVC

        cell.selectionStyle = .none
        
        let str = myArray[indexPath.row]
        cell.labelBody?.textColor = .white
        cell.labelNum.font = .myBoldSystemFont(ofSize: 62)
        cell.labelNum.text = "0\(indexPath.row + 1)"
        cell.labelSubTitle.text = "\(dailyModel?.data.result[indexPath.row].tasks.count ?? 0)개의 기록이 당신을 기다리고 있어요."
        cell.myInit(theTitle: " \((dailyModel?.data.result[indexPath.row].name) ?? "")", theBody: str)
       
        let attributedString = NSMutableAttributedString(string: cell.labelSubTitle.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainOrange, range: (cell.labelSubTitle.text! as NSString).range(of:"\(dailyModel?.data.result[indexPath.row].tasks.count ?? 0)개의 기록"))
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
        let param = DailyRequest.init("1610333510000")
        authProvider.request(.dailyinquiry(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(DailyModel.self)
                        self.dailyModel = data
                        self.setDropData()
                        self.tableView.reloadData()
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
