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
    var isGoalCompleted = false
    var weekText: String? = nil
    var listCount = 0
    var cellNum = 0
    
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
            cell.setData(goal: goal, isGoalCompleted: isGoalCompleted)
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
}

//MARK: Action
extension EvaluationDetailVC {
    @IBAction func touchUpBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UI
extension EvaluationDetailVC {
    func setData() {
        
    }
    
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
        let pathToString = "\(cellNum)"
        let param = ViewDetailReportRequest.init(pathToString, "1610290800000", "1610982000000")
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
                        self.isGoalCompleted = ((self.keywordData?.data.isGoalCompleted) != nil)
                        //DetailRecordTVC, DetailRecordContent
                        self.listCount = self.keywordData?.data.tasks.count ?? 0
                        for i in 0...self.listCount-1 {
                            guard let tasks = self.keywordData?.data.tasks[i] else {return}
                            print(tasks)
                            self.task.append(tasks)
                        }
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
