//
//  EvaluationDetailVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/02.
//

import UIKit
import Moya

class EvaluationDetailVC: UIViewController {
    private let authProvider = MoyaProvider<ReportServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var keywordData: ViewDetailReportModel?
    
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var keywordDetailTableView: UITableView!
    
    var goal: String = ""
    var weekText: String? = nil
    var listCount = 0
    var cellNum = 0
    var isGoalComplete = false
    var isGoalExist = false
    var start: Date?
    var end: Date?
    
    var task: [Tasks] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getKeywordDetail()
        setNavigationBar()
        setTableView()
        setLabel()
    }
}

extension EvaluationDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGoalTVC.identifier) as? DetailGoalTVC else {
                return UITableViewCell()
            }
            cell.setData(goal: goal, isGoalCompleted: isGoalComplete, isGoalExist: isGoalExist)
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecordTVC.identifier) as? DetailRecordTVC else {
                return UITableViewCell()
            }
            cell.setData(count: listCount)
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecordContentTVC.identifier) as? DetailRecordContentTVC else {
            return UITableViewCell()
        }
        cell.setList(task: task)
        print(task)
        cell.selectionStyle = .none
        return cell
    }
}

extension EvaluationDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 91
        } else if indexPath.section == 1 {
            return 42
        }
        
        var calculateHeight: CGFloat = 0
        if listCount == 0 {
            calculateHeight = 368
        }   else if listCount % 2 == 0 {
            calculateHeight = CGFloat(42 + listCount / 2 * 185)
        } else {
            if listCount == 1 {
                calculateHeight = 222
            }
            calculateHeight = CGFloat(42 + (listCount / 2 + 1) * 185)
        }
        return calculateHeight
    }
    
    //MARK: 유진아 여기야 여기야
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if isGoalExist {
                // ### isGoalExist면 선택했을 때 이동
            }
        }
    }
}

//MARK: Action
extension EvaluationDetailVC {
    @IBAction func touchUpBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UI
extension EvaluationDetailVC {
    private func setNavigationBar() {
        navigationTitleLabel.text = "회고"
        navigationTitleLabel.textColor = .mainBlack
        navigationTitleLabel.font = .myBoldSystemFont(ofSize: 20)
    }
    
    private func setTableView() {
        keywordDetailTableView.delegate = self
        keywordDetailTableView.dataSource = self
        keywordDetailTableView.rowHeight = UITableView.automaticDimension
        keywordDetailTableView.estimatedRowHeight = 100
        keywordDetailTableView.separatorColor = .clear
    }
    
    private func setLabel() {
        keywordLabel.font = .myBoldSystemFont(ofSize: 32)
        keywordLabel.textColor = .mainBlack
        
        weekLabel.font = .myRegularSystemFont(ofSize: 12)
        weekLabel.text = weekText
        weekLabel.textColor = .mainGray
    }
}

//MARK: Network
extension EvaluationDetailVC {
    func getKeywordDetail() {
        let path = cellNum
        guard let startDate = start?.millisecondsSince1970 else {return}
        guard let endDate = end?.millisecondsSince1970 else {return}
        let startString = "\(startDate)"
        let endString = "\(endDate)"
        let param = ViewDetailReportRequest.init(path, startString, endString)
        print(param)
        authProvider.request(.viewDetailReport(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        self.keywordData = try result.map(ViewDetailReportModel.self)
                        //EvaluationDetailVC
                        self.keywordLabel.text = self.keywordData?.data.keywordName
                        // DetailGoalTVC
                        self.goal = self.keywordData?.data.goal ?? ""
                        self.isGoalExist = self.keywordData?.data.goalExist ?? false
                        self.isGoalComplete = self.keywordData?.data.isGoalCompleted ?? false
                        //DetailRecordTVC, DetailRecordContent
                        self.task.removeAll()
                        if self.listCount != 0 {
                            for i in 0...self.listCount-1 {
                                guard let tasks = self.keywordData?.data.tasks[i] else {return}
                                self.task.append(tasks)
                            }
                        }
                        self.keywordDetailTableView.reloadData()
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
