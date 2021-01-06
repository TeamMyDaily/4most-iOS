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
    @IBOutlet weak var dateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(.clear)
        setUI()
    }
    @IBAction func dateButton(_ sender: Any) {
//        var picker : UIDatePicker = UIDatePicker()
//        picker.datePickerMode = UIDatePicker.Mode.date
//        picker.addTarget(self, action: "dueDateChanged:", for: UIControl.Event.valueChanged)
//        let pickerSize : CGSize = picker.sizeThatFits(CGSize())
//        picker.frame = CGRect(x: 0.0, y: 250, width: pickerSize.width, height: 460)
//            // you probably don't want to set background color as black
//            // picker.backgroundColor = UIColor.blackColor()
//            self.view.addSubview(picker)
    }
    
}

//MARK: - UI
extension DailyVC {
    func setUI() {
        headerView.layer.addBorder([.top,.bottom], color: UIColor.blueGray20, width: 1.0)
        
        datePicker.maximumDate = Date()
    }
}
