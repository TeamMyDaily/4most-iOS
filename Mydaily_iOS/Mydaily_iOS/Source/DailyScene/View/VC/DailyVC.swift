//
//  DailyVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class DailyVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var userDaily: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(.clear, titlelabel: "")
        setUI()
    }
   
    @IBAction func changedDate(_ sender: Any) {
        setDate()
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
        }
        else{
            dateLabel.textColor = .mainOrange
        }
    }
}
