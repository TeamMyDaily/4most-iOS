//
//  MypageVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class MypageVC: UIViewController {

    @IBOutlet weak var keywordSettingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
  // Do any additional setup after loading the view.
    }
    
    @IBAction func goToSettingKeywordView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Keyword", bundle: nil)

        let dvc = storyboard.instantiateViewController(identifier: "KeywordSettingVCNavigation")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)

        //키워드 설정
//        let vc = storyboard.instantiateViewController(identifier: "KeywordDefineVC")
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    
}
