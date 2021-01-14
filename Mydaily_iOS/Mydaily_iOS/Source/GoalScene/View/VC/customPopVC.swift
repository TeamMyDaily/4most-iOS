//
//  customPopVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/14.
//

import UIKit

class customPopVC: UIViewController {

    @IBOutlet weak var dismissButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
    }

    func setUI(){
        dismissButton.font = .myRegularSystemFont(ofSize: 12)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
