//
//  GoalVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/07.
//

import UIKit

class GoalVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var goalCountLabel: UILabel!
    @IBOutlet weak var goalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar(.clear, titlelabel: "목표")
        setDateLabel()
        setupTableView()
        setUI()
    }
}

extension GoalVC {
    func setDateLabel(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        dateLabel.text = dateFormatter.string(from: Date())
        
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
        guard let VC = self.storyboard?.instantiateViewController(identifier: "GoalWriteVC") as? GoalWriteVC else {return}
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

