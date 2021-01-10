//
//  GoalDetailVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/10.
//

import UIKit

class GoalDetailVC: UIViewController {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var checkButton: UIImageView!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var goalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GoalDetailVC {
    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        self.navigationItem.title = "기록"
        
        //        let leftButton: UIBarButtonItem = {
        //            let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
        //            return button
        //        }()
        
        let rightButton: UIBarButtonItem = {
            let button = UIBarButtonItem(title: "수정", style: .done, target: self, action: nil)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .normal)
            button.setTitleTextAttributes([
                                            NSAttributedString.Key.font: UIFont.myRegularSystemFont(ofSize: 17),
                                            NSAttributedString.Key.foregroundColor: UIColor.mainOrange], for: .selected)
            
            return button
        }()
        
//                let leftButton: UIBarButtonItem = {
//                    let button = UIBarButtonItem(image: UIImage(named: "backArrowIc"), style: .plain, target: self, action: #selector(dismissVC))
//                    return button
//                }()
//                navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setUI(){
        weekLabel.text = "20년 12월 3주"
        weekLabel.font = .myBoldSystemFont(ofSize: 12)
        weekLabel.textColor = .mainGray
        
        keywordLabel.text = "아웃풋에 가까워지기 위한 목표"
        keywordLabel.font = .myMediumSystemFont(ofSize: 15)
        keywordLabel.textColor = .mainBlack
        
        goalLabel.text = "블로그에 1개이상 퍼블리싱하기"
        goalLabel.numberOfLines = 2
        goalLabel.font = .myBlackSystemFont(ofSize: 32)
        goalLabel.textColor = .mainBlack
        goalLabel.sizeToFit()
        
        checkLabel.text = "목표 달성시 체크"
        checkLabel.font = .myLightSystemFont(ofSize: 12)
        checkLabel.textColor = .mainGray
        
        goalButton.layer.cornerRadius = 15
        goalButton.backgroundColor = .mainGray
        goalButton.setTitle("목표 달성", for: .normal)
        goalButton.setTitleColor(.white, for: .normal)
        goalButton.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
    }
}
