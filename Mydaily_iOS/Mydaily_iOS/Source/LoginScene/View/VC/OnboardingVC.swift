//
//  OnboardingVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/15.
//

import UIKit

class OnboardingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        goOnBoardPopUp()
    }
    

    func goOnBoardPopUp(){
            let keywordStoryboard = UIStoryboard(name: "Keyword", bundle: nil)
            let dvc = keywordStoryboard.instantiateViewController(identifier: "KeywordPopUpVC")  as! KeywordPopUpVC
            
            dvc.checkOnBoard(check: true)
            
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }

}
