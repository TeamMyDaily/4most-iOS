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
        setDateLabel()
        setUI()
        setupTableView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 W주"
        print("\(dateFormatter.string(from: Date().containWeek!))")
    }
}

extension GoalVC {
    func setDateLabel(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 W주"
        dateLabel.text = dateFormatter.string(from: Date().containWeek!)
        dateLabel.textColor = .mainOrange
        dateLabel.font = .myBoldSystemFont(ofSize: 12)
        dateLabel.sizeToFit()
    }
    
    func setUI(){
        defaultLabel.text = "키워드에 따른\n목표를 설정해주세요!"
        defaultLabel.font = .myBlackSystemFont(ofSize: 25)
        defaultLabel.textColor = .mainBlack
        defaultLabel.numberOfLines = 2
        defaultLabel.sizeToFit()
        
        goalCountLabel.text = "4개의 목표가 미설정 되었어요!"
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTVC.reuseIdentifier, for: indexPath)
                as? GoalTVC else { return UITableViewCell() }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalWriteVC") as? GoalWriteVC else {return}
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else{
            guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalDetailVC") as? GoalDetailVC else {return}
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

// MARK: - 통신
extension GoalVC{
    func getGoal(){
        let param = GoalRequest.init("1610290800000","1610982000000")
        authProvider.request(.goalinquiry(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(GoalModel.self)
                        self.goalData = data
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}

