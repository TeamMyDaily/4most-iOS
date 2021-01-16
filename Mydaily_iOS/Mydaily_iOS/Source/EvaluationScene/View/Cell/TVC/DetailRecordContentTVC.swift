//
//  DetailRecordContentCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/03.
//

import UIKit

class DetailRecordContentTVC: UITableViewCell {
    static let identifier = "DetailRecordContentTVC"
    
    @IBOutlet weak var recordCollectionView: UICollectionView!
    @IBOutlet weak var noRecordView: UIView!
    
    lazy var notifyLabel: UILabel = {
        let notifyLabel = UILabel()
        notifyLabel.translatesAutoresizingMaskIntoConstraints = false
        return notifyLabel
    }()
    
    var delegate: RecordToDailyDelegate?
    var tableView: UITableView?
    
    var keywordId: Int? = nil
    var taskId: [Int] = []
    var taskTitle: [String] = []
    var taskDate: [String] = []
    var taskSatisfaction: [Int] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        taskTitle = []
        setNotification()
        hideViewIfListEmpty()
        setNoRecordView()
        setCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension DetailRecordContentTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailRecordCVC.identifier, for: indexPath as IndexPath) as! DetailRecordCVC
        cell.setLabelText(content: taskTitle[indexPath.item], date: taskDate[indexPath.item], satisfaction: taskSatisfaction[indexPath.item])
        print("^^^^\(taskTitle)")
        return cell
    }
}

extension DetailRecordContentTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 16)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension DetailRecordContentTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dvc = UIStoryboard(name: "Daily", bundle: nil).instantiateViewController(withIdentifier: "DailyWriteVC") as? DailyWriteVC else {
            return
        }
        dvc.keywordID = keywordId
        dvc.taskID = taskId[indexPath.item]
        dvc.taskTitle = taskTitle[indexPath.item]
        delegate?.cellTapedDaily(dvc: dvc)
    }
    
}

//MARK: UI
extension DetailRecordContentTVC {
    func setList(task: [Tasks]) {
        if !task.isEmpty {
            print(task)
            for i in 0...task.count-1 {
                taskTitle.append(task[i].title)
                taskSatisfaction.append(task[i].satisfaction)
                taskId.append(task[i].taskId)
                
                let start = String.Index(encodedOffset: 0)
                let end = String.Index(encodedOffset: 10)
                let substring = String(task[i].date[start..<end])
                let dateString = substring.replacingOccurrences(of: "-", with: ".",
                                               options: NSString.CompareOptions.literal, range:nil)
                taskDate.append(dateString)
                recordCollectionView.reloadData()
                print("ddd")
            }
        }
        
        hideViewIfListEmpty()
        recordCollectionView.reloadData()
    }
    
    private func setNoRecordView() {
        noRecordView.addSubview(notifyLabel)
        
        notifyLabel.bottomAnchor.constraint(equalTo: noRecordView.bottomAnchor, constant: -132).isActive = true
        notifyLabel.centerXAnchor.constraint(equalTo: noRecordView.centerXAnchor).isActive = true
        notifyLabel.font = .myRegularSystemFont(ofSize: 12)
        notifyLabel.text = "이 날에는 키워드가 없어요.😢"
        notifyLabel.textColor = .mainGray
        notifyLabel.textAlignment = .center
        notifyLabel.numberOfLines = 0
    }
}

//MARK: Notification
extension DetailRecordContentTVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: NSNotification.Name("reloadCollection"), object: nil)
    }
    
    @objc func reloadCollection() {
        hideViewIfListEmpty()
        recordCollectionView.reloadData()
    }
}

//MARK: View
extension DetailRecordContentTVC {
    private func hideViewIfListEmpty() {
        if taskTitle.isEmpty {
            recordCollectionView.isHidden = true
            noRecordView.isHidden = false
        } else {
            recordCollectionView.isHidden = false
            noRecordView.isHidden = true
        }
    }
}

//MARK: CollectionView
extension DetailRecordContentTVC: DetailRecordLayoutDelegate {
    private func setCollectionView() {
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
        recordCollectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        if let layout = recordCollectionView.collectionViewLayout as? DetailRecordLayout {
            layout.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForLabelAtIndexPath indexPath: IndexPath) -> CGFloat {
        let width = (collectionView.bounds.size.width - (collectionView.contentInset.left + collectionView.contentInset.right + 16 + 16 + 30)) / 2 - 30
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = taskTitle[indexPath.item]
        label.preferredMaxLayoutWidth = width
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.contentMode = .scaleToFill
        label.font = .myBoldSystemFont(ofSize: 16)
        label.sizeToFit()
        
        let calculateHeight = label.intrinsicContentSize.height + 120
        return calculateHeight
    }
}
