//
//  evaluationTabCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/01.
//

import UIKit

class EvaluationTabCVC: UICollectionViewCell {
    static let identifier = "EvaluationTabCVC"
    
    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    lazy var notifyLabel: UILabel = {
        let notifyLabel = UILabel()
        notifyLabel.translatesAutoresizingMaskIntoConstraints = false
        return notifyLabel
    }()
    
    lazy var createKeywordButton: UIButton = {
        let createKeywordButton = UIButton()
        createKeywordButton.translatesAutoresizingMaskIntoConstraints = false
        return createKeywordButton
    }()
    
    var delegate: TableViewInsideCollectionViewDelegate?
    
    var dateValue = 0
    
    var keywords = ["아웃풋", "열정", "경청", "선한영향력", "진정성", "자신감", "노력"]
    var goals = ["블로그에 1개 이상 퍼블리싱 하기", "열정 만수르 유노윤호의 영상보고 감상문 5장 이상 쓰기", "PM님 말씀하실 때 가위춤추지 않기", "거짓말 치지 않고 선하게 살기", "열정 만수르 유노윤호의 영상보고 감상문 5장 이상 쓰기", "PM님 말씀하실 때 가위춤추지 않기", "거짓말 치지 않고 선하게 살기"]
    var rates = [2.6, 4.2, nil, 3.4, 4.2, 1.5, 3.4]
    var counts = [3, 3, 2, 1, 6, 6, 7]
    var removeIndex: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableView()
        setViewWithoutTableView()
        setNotification()
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
        cell.setCellInsideData(keyword: keywords[indexPath.item] ?? "", goal: goals[indexPath.item] ?? "", index: indexPath.item, rate: rates[indexPath.item] ?? 0, count: Int(counts[indexPath.item] ?? 0))
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
        noDataView.addSubview(createKeywordButton)
        
        notifyLabel.centerYAnchor.constraint(equalTo: noDataView.centerYAnchor).isActive = true
        notifyLabel.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor).isActive = true
        notifyLabel.font = .myRegularSystemFont(ofSize: 12)
        notifyLabel.textColor = .mainGray
        notifyLabel.textAlignment = .center
        notifyLabel.numberOfLines = 0
    }
    
    private func setViewByDateValue() {
        if dateValue == 0 {
            notifyLabel.text = "키워드가 존재 하지 않아 목표를 생성 할 수 없어요.😢\n + 버튼을 눌러 키워드를 생성 해 보세요!"
            
            createKeywordButton.topAnchor.constraint(equalTo: notifyLabel.bottomAnchor, constant: 47).isActive = true
            createKeywordButton.centerXAnchor.constraint(equalTo:noDataView.centerXAnchor).isActive = true
            createKeywordButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            createKeywordButton.widthAnchor.constraint(equalToConstant: 114).isActive = true
            createKeywordButton.titleLabel?.font = .myMediumSystemFont(ofSize: 16)
            createKeywordButton.setTitle("키워드 생성", for: .normal)
            createKeywordButton.titleLabel?.textAlignment = .left
            createKeywordButton.titleLabel?.textColor = .white
            createKeywordButton.backgroundColor = .mainOrange
            createKeywordButton.layer.cornerRadius = 15
            createKeywordButton.layer.masksToBounds = true
            createKeywordButton.isHidden = false
            createKeywordButtonAddTarget()
        } else {
            notifyLabel.text = "이 주에는 키워드와 목표가 없어요.😢"
            createKeywordButton.isHidden = true
        }
    }
}

//MARK: View
extension EvaluationTabCVC {
    private func setViewWithoutTableView() {
        setNoDataView()
        setViewByDateValue()
        
        if keywords[0] == nil {
            keywordTableView.isHidden = true
            noDataView.isHidden = false
        } else {
            keywordTableView.isHidden = false
            noDataView.isHidden = true
        }
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

//MARK: Button
extension EvaluationTabCVC {
    private func createKeywordButtonAddTarget() {
        createKeywordButton.addTarget(self, action: #selector(touchUpCreateKeyword), for: .touchUpInside)
    }
    
    @objc func touchUpCreateKeyword() {
        print("create")
    }
}

//MARK: Notification
extension EvaluationTabCVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendBeforeWeek), name: NSNotification.Name(rawValue: "LastWeek"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendAfterWeek), name: NSNotification.Name(rawValue: "NextWeek"), object: nil)
    }
    
    @objc func sendBeforeWeek() {
        dateValue -= 1
        setViewByDateValue()
        noDataView.setNeedsLayout()
        noDataView.layoutIfNeeded()
    }
    
    @objc func sendAfterWeek() {
        dateValue += 1
        setViewByDateValue()
        noDataView.setNeedsLayout()
        noDataView.layoutIfNeeded()
    }
}
