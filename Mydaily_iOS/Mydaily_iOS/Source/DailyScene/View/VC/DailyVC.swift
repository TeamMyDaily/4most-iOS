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
        
        for _ in 1...4 {
            
            let n = arc4random_uniform(6) + 4
            var str = ""
            for i in 1..<n {
                str += "Line \(i)\n"
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
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTVC.reuseIdentifier, for: indexPath) as! DetailTVC

        cell.selectionStyle = .none
        
        let str = myArray[indexPath.row]
        cell.labelBody?.textColor = .white
        cell.myInit(theTitle: "아웃풋", theBody: str)
        
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
//        authProvider.request(.dailyinquiry("?date=1610333510000")) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//                case .success(let response):
//                    do {
//                        let data = try response.map(DailyModel.self)
//                        print(data)
//                        self.dailyModel = data
////                        print(self.dailyModel)
//                        self.tableView.reloadData()
//                    } catch(let err) {
//                        print(err.localizedDescription)
//                    }
//                case .failure(let err):
//                    print(err.localizedDescription)
//            }
//        }
        
        authProvider.request(.dailyinquiry("?date=1610333510000")) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(DailyModel.self)
                        self.dailyModel = data
                        print(self.dailyModel)
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
//                    self.token = try err.map(SigninModel.self)
//                    print("@\(self.token)")
                    print(err.localizedDescription)
            }
        }
    }
}
