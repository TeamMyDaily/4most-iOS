//
//  EvaluationVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

class EvaluationVC: UIViewController {
    @IBOutlet weak var evaluationTabButton: UIButton!
    @IBOutlet weak var retrospectiveTabButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var evaluationTabBar: UIView!
    @IBOutlet weak var retrospectiveTabBar: UIView!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    let originalButtonColor: UIColor = UIColor.init(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
    let selectedButtonColor: UIColor = UIColor.init(red: 236/255, green: 104/255, blue: 74/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuTabButton()
        setCollectionViewDelegate()
    }
    
    @IBAction func touchUpEvaluationTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in
                IndexPath(item: 0, section: 0)
            }), keywordCollectionView.cellForItem(at: indexPath) != nil else {
                return
            }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        setButtonState(enableButton: evaluationTabButton, unableButton: retrospectiveTabButton, enableTabBar: evaluationTabBar, unableTabBar: retrospectiveTabBar)
    }
    
    @IBAction func touchUpRetrospectiveTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in
                IndexPath(item: 0, section: 1)
            }), keywordCollectionView.cellForItem(at: indexPath) != nil else {
                return
            }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        setButtonState(enableButton: retrospectiveTabButton, unableButton: evaluationTabButton, enableTabBar: retrospectiveTabBar, unableTabBar: evaluationTabBar)
    }
}

extension EvaluationVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvaluationTabCVC.identifier, for: indexPath) as? EvaluationTabCVC else {
                return UICollectionViewCell()
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RetrospectiveTabCVC.identifier, for: indexPath) as? RetrospectiveTabCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension EvaluationVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension EvaluationVC {
    private func setMenuTabButton() {
        evaluationTabButton.setTitleColor(selectedButtonColor, for: .normal)
        evaluationTabButton.setTitle("평가", for: .normal)
        evaluationTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        retrospectiveTabButton.setTitleColor(originalButtonColor, for: .normal)
        retrospectiveTabButton.setTitle("회고", for: .normal)
        retrospectiveTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        retrospectiveTabBar.isHidden = true
    }
    
    private func setButtonState(enableButton: UIButton, unableButton: UIButton, enableTabBar: UIView, unableTabBar: UIView) {
        enableButton.setTitleColor(selectedButtonColor, for: .normal)
        unableButton.setTitleColor(originalButtonColor, for: .normal)
        enableTabBar.isHidden = false
        unableTabBar.isHidden = true
    }
    
    private func setCollectionViewDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
}
