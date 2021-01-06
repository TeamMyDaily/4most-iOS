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
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(.clear)
        setUI()
    }
   
    @IBAction func changedDate(_ sender: Any) {
        setDate()
    }
}

//MARK: - UI
extension DailyVC {
    func setUI() {
        headerView.layer.addBorder([.top,.bottom], color: UIColor.blueGray20, width: 1.0)
        
        datePicker.maximumDate = Date()
        
        setDate()
    }
    
    func setDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
}
