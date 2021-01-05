//
//  DailyVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class DailyVC: UIViewController {
    
    @IBOutlet weak var recordTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupStatusBar(.gray)
        
//        recordTableView.estimatedRowHeight =
    }
    
}

//MARK: - UI
extension DailyVC {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - my cell delegate
//    func moreTapped(cell: DailyTVC) {
//        
//        // this will "refresh" the row heights, without reloading
//        recordTableView.beginUpdates()
//        recordTableView.endUpdates()
//        
//        // do anything else you want because the switch was changed
//        
//    }
    
    func setUI() {
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.gray
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "4most"
    }
    
    func setupStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}
