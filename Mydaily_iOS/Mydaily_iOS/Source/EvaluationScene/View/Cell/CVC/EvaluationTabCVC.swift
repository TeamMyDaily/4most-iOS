//
//  evaluationTabCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/01.
//

import UIKit
import Moya

class EvaluationTabCVC: UICollectionViewCell {
    static let identifier = "EvaluationTabCVC"
    
    private let authProvider = MoyaProvider<ReportServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var textData: ViewReportModel?
    
    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    lazy var notifyImage: UIImageView = {
        let notifyImage = UIImageView()
        notifyImage.translatesAutoresizingMaskIntoConstraints = false
        return notifyImage
    }()
    
    lazy var notifyLabel: UILabel = {
        let notifyLabel = UILabel()
        notifyLabel.translatesAutoresizingMaskIntoConstraints = false
        return notifyLabel
    }()
    
    var delegate: TableViewInsideCollectionViewDelegate?
    var collectionView: UICollectionView?
    
    var weekText: String? = nil
    var start: Date?
    var end: Date?
    var dateValue = 0
    let changeDateValue = 86400 * 7
    
    var totalKeywordId: [Int] = []
    var keywords: [String] = []
    var goals: [String] = []
    var rates: [String] = []
    var counts: [Int] = []
    var removeIndex: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setNotification()
        setDate()
        getText()
        setViewWithoutTableView()
        setTableView()
        makeUpArrayOfData()
    }
}

extension EvaluationTabCVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        var cnt = 0
        for i in counts {
            if i != 0 {
                cnt += 1
            }
        }
        return cnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EvaluationHeaderTVC.identifier) as? EvaluationHeaderTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EvaluationKeywordTVC.identifier) as? EvaluationKeywordTVC else {
            return UITableViewCell()
        }
        cell.setCellInsideData(keyword: keywords[indexPath.item] ?? "", goal: goals[indexPath.item] ?? "", index: indexPath.item, rate: rates[indexPath.item] ?? "0", count: Int(counts[indexPath.item] ?? 0))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 129
        }
        return 100
    }
}

extension EvaluationTabCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if keywords[indexPath.row] != nil {
                guard let dvc = UIStoryboard(name: "Evaluation", bundle: nil).instantiateViewController(identifier: "EvaluationDetailVC") as? EvaluationDetailVC else {
                    return
                }
                dvc.listCount = counts[indexPath.row]
                dvc.weekText = weekText
                dvc.cellNum = totalKeywordId[indexPath.row]
                dvc.start = start
                dvc.end = end
                self.delegate?.cellTapedEvaluation(dvc: dvc)
            }
        }
    }
}

//MARK: UI
extension EvaluationTabCVC {
    private func setTableView() {
        keywordTableView.separatorStyle = .none
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
    }
    
    private func setNoDataView() {
        noDataView.addSubview(notifyLabel)
        noDataView.addSubview(notifyImage)
        
        notifyLabel.centerYAnchor.constraint(equalTo: noDataView.centerYAnchor, constant: -50).isActive = true
        notifyLabel.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        notifyLabel.font = .myRegularSystemFont(ofSize: 12)
        notifyLabel.textColor = .mainGray
        notifyLabel.textAlignment = .center
        notifyLabel.numberOfLines = 0
        notifyLabel.text = "리포트 내용이 없어요"
        
        notifyImage.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        notifyImage.bottomAnchor.constraint(equalTo: notifyLabel.topAnchor, constant: -24).isActive = true
        notifyImage.widthAnchor.constraint(equalToConstant: 184).isActive = true
        notifyImage.heightAnchor.constraint(equalToConstant: 132).isActive = true
        notifyImage.image = UIImage(named: "imageRest")
    }
}

//MARK: View
extension EvaluationTabCVC {
    private func setViewWithoutTableView() {
        setNoDataView()
    }
}

//MARK: Array
extension EvaluationTabCVC {
    private func makeUpArrayOfData() {
        var index = 0
        removeIndex.removeAll()
        
        for i in counts {
            if i == 0 {
                removeIndex.append(index)
            }
            index += 1
        }
        
        for i in removeIndex.reversed() {
            keywords.remove(at: i)
            goals.remove(at: i)
            rates.remove(at: i)
            counts.remove(at: i)
        }
    }
}

//MARK: Date
extension EvaluationTabCVC {
    private func setDate() {
        dateValue = 0
        start = Date().startOfWeek
        end = Date().endOfWeek
    }
}

//MARK: Notification
extension EvaluationTabCVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getReport), name: NSNotification.Name("reloadReport"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getInitReport), name: NSNotification.Name("reloadInitReport"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendBeforeWeek), name: NSNotification.Name(rawValue: "LastWeek"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendAfterWeek), name: NSNotification.Name(rawValue: "NextWeek"), object: nil)
    }
    
    @objc func getInitReport() {
        getText()
    }
    
    @objc func getReport() {
        setDate()
        getText()
    }
    
    @objc func sendBeforeWeek() {
        dateValue -= (1 * changeDateValue)
        start = (Date().startOfWeek ?? Date()) + TimeInterval(dateValue)
        end = (Date().endOfWeek ?? Date()) + TimeInterval(dateValue)
        getText()
        collectionView?.reloadData()
        keywordTableView.reloadData()
    }
    
    @objc func sendAfterWeek() {
        dateValue += (1 * changeDateValue)
        start = (Date().startOfWeek ?? Date()) + TimeInterval(dateValue)
        end = (Date().endOfWeek ?? Date()) + TimeInterval(dateValue)
        getText()
        collectionView?.reloadData()
        keywordTableView.reloadData()
    }
}

//MARK: Network
extension EvaluationTabCVC {
    func getText() {
        let current = Date()
        print("start: \(start!)")
        print("end: \(end!)")
        print("today: \(current)")
        guard let startDate = start?.millisecondsSince1970 else {return}
        guard let endDate = end?.millisecondsSince1970 else {return}
        let startString = "\(startDate)"
        let endString = "\(endDate)"
        let param = ViewRequest.init(startString, endString)
        authProvider.request(.viewReport(param: param)) { response in
            switch response {
                case .success(let result):
                    do {
                        self.textData = try result.map(ViewReportModel.self)
                        if self.textData?.data.keywordsExist == false || (self.textData?.data.keywordsExist == true && self.textData?.data.result?.isEmpty ?? true) {
                            self.keywordTableView.isHidden = true
                            self.noDataView.isHidden = false
                        } else {
                            self.keywordTableView.isHidden = false
                            self.noDataView.isHidden = true
                            if self.textData?.data.result?.count != 0 {
                                self.totalKeywordId.removeAll()
                                self.keywords.removeAll()
                                self.counts.removeAll()
                                self.goals.removeAll()
                                self.rates.removeAll()
                                for i in 0...(self.textData?.data.result?.count ?? 0)-1 {
                                    self.totalKeywordId.append(self.textData?.data.result?[i].totalKeywordID ?? 0)
                                    self.keywords.append(self.textData?.data.result?[i].keyword ?? "")
                                    self.counts.append(self.textData?.data.result?[i].taskCnt ?? 0)
                                    self.goals.append(self.textData?.data.result?[i].weekGoal ?? "")
                                    self.rates.append(self.textData?.data.result?[i].taskSatisAvg ?? "")
                                }
                            }
                            self.keywordTableView.reloadData()
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
