//
//  GoalVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/07.
//

import UIKit
import Moya

class GoalVC: UIViewController {
    private let authProvider = MoyaProvider<GoalService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var goalData: GoalModel?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var goalCountLabel: UILabel!
    @IBOutlet weak var goalTableView: UITableView!
    var date = Date()
    let dateButton: UIButton = {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.setTitle("오늘 >", for: .normal)
                $0.layer.cornerRadius = 20
                $0.backgroundColor = .mainBlack
                $0.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
                $0.setTitleColor(.white, for: .normal)
//                $0.addTarget(self, action: #selector(setToday), for: .allTouchEvents)
                return $0
            }(UIButton(frame: .zero))
    
    override func viewWillAppear(_ animated: Bool) {
        getGoal()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(.clear, titlelabel: "목표")
        setDateLabel(date: date)
        setUI()
        setupTableView()
    }
    @IBAction func moveWeekdown(_ sender: Any) {
        self.date = Calendar.current.date(byAdding: .day, value: -7, to: date)!
        setDateLabel(date: date)
        getGoal()
        
        if date == Date(){
            self.dateLabel.textColor = .mainOrange
        }
        else{
            self.dateLabel.textColor = .mainBlack
        }
    }
    @IBAction func moveWeekup(_ sender: Any) {
        self.date = Calendar.current.date(byAdding: .day, value: 8, to: date)!
        setDateLabel(date: date)
        getGoal()
        
        if date == Date(){
            self.dateLabel.textColor = .mainOrange
        }
        else{
            self.dateLabel.textColor = .mainBlack
        }
    }
}

extension GoalVC {
    func DateInMilliSeconds(date: Date)-> Int
    {
        print(Int(date.startOfWeek!.timeIntervalSince1970 * 1000))
        print(Int(date.endOfWeek!.timeIntervalSince1970 * 1000))
        return Int(date.startOfWeek!.timeIntervalSince1970 * 1000)
    }
    
    func setDateLabel(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 W주"
        dateLabel.text = dateFormatter.string(from: date.containWeek!)
        dateLabel.textColor = .mainOrange
        dateLabel.font = .myBoldSystemFont(ofSize: 12)
        dateLabel.sizeToFit()
    }
    
    func setUI(){
        defaultLabel.font = .myBlackSystemFont(ofSize: 25)
        defaultLabel.textColor = .mainBlack
        defaultLabel.numberOfLines = 2
        defaultLabel.sizeToFit()
        
        goalCountLabel.font = .myRegularSystemFont(ofSize: 12)
        goalCountLabel.textColor = .mainOrange
        goalCountLabel.sizeToFit()
 
        self.goalTableView.addSubview(dateButton)
        
        NSLayoutConstraint.activate([
            dateButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            dateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dateButton.widthAnchor.constraint(equalToConstant: 66),
            dateButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        updateUI()
    }
    
    func updateUI(){
        if goalData?.data.keywordsExist == false{
            //empty view
            
        }
        else{
            if goalData?.data.result.notSetGoalCount == 0{
                defaultLabel.text = "키워드에 따른\n목표를 설정해주세요!"
            }
            else{
                defaultLabel.text = "키워드에 따른\n기록을 설정해주세요!"
            }
            goalCountLabel.text = "\(goalData?.data.result.notSetGoalCount ?? 0)개의 목표가 미설정 되었어요!"
        }
    }
}

extension GoalVC: UITableViewDelegate{}
extension GoalVC: UITableViewDataSource{
    
    func setupTableView() {
        goalTableView.delegate = self
        goalTableView.dataSource = self
        goalTableView.separatorStyle = .none
//        goalTableView.isScrollEnabled = false

        let containNibname = UINib(nibName: GoalTVC.nibName, bundle: nil)
        goalTableView.register(containNibname, forCellReuseIdentifier: GoalTVC.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goalData?.data.keywordsExist == true{
            return goalData?.data.result.count ?? 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTVC.reuseIdentifier, for: indexPath)
                as? GoalTVC else { return UITableViewCell() }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        
        cell.keywordName.text = "\(self.goalData?.data.result.keywords[indexPath.row].name ?? "")"
        
        if self.goalData?.data.result.keywords[indexPath.row].isGoalCreated == true{
            cell.keywordDetail.text = "\(self.goalData?.data.result.keywords[indexPath.row].weekGoal ?? "")"
            cell.keywordName.textColor = .mainBlack
            cell.keywordDetail.textColor = .mainBlack
            cell.addButton.setImage(UIImage(named: "btnChevronRight"), for: .normal)
        }
        else{
            cell.keywordDetail.text = "목표를 세워주세요."
            cell.addButton.setImage(UIImage(named: "btnAddS"), for: .normal)
            cell.keywordName.textColor = .mainGray
            cell.keywordDetail.textColor = .mainGray
        }
        
        if self.goalData?.data.result.keywords[indexPath.row].isGoalCompleted == true{
            cell.outterView.borderColor = .mainOrange
            cell.achieveImg.image = UIImage(named: "btn_attainment_o")
        }
        else{
            cell.outterView.borderColor = .mainLightGray
            cell.achieveImg.image = UIImage(named: "btn_not_attainment")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.goalData?.data.result.keywords[indexPath.row].isGoalCreated == false {
            guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalWriteVC") as? GoalWriteVC else {return}
            VC.goalDataKeywordID = self.goalData?.data.result.keywords[indexPath.row].totalKeywordID
            VC.goalKeywordName = self.goalData?.data.result.keywords[indexPath.row].name
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else{
            guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalDetailVC") as? GoalDetailVC else {return}
            VC.KeywordDate = self.goalData?.data.result.keywords[indexPath.row]
            VC.week = self.dateLabel.text
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

// MARK: - 통신
extension GoalVC{
    func getGoal(){
        let param = GoalRequest.init("\(DateInMilliSeconds(date: self.date.startOfWeek!))","\(DateInMilliSeconds(date: self.date.endOfWeek!))")
        authProvider.request(.goalinquiry(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(GoalModel.self)
                        self.goalData = data
                        self.updateUI()
                        self.goalTableView.reloadData()
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}

