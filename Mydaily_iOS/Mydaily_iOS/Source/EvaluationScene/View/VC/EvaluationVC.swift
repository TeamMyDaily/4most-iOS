//
//  EvaluationVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2020/12/30.
//

import UIKit

protocol TableViewTnsideCollectionViewDelegate: class {
    func cellTaped()
}

protocol PushDelegate {
  func makeNavigationPush(_ vc: UIViewController)
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

class EvaluationVC: UIViewController {
    @IBOutlet weak var weekLabel: UILabel!
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
        setWeekLabel()
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
    
        setButtonState(enableButton: evaluationTabButton, disableButton: retrospectiveTabButton, enableTabBar: evaluationTabBar, unableTabBar: retrospectiveTabBar)
        
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
    }
    
    @IBAction func touchUpRetrospectiveTab(_ sender: Any) {
        guard let indexPath = keywordCollectionView.indexPathsForVisibleItems.first.flatMap({_ in
                IndexPath(item: 0, section: 1)
            }), keywordCollectionView.cellForItem(at: indexPath) != nil else {
                return
            }
        keywordCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        setButtonState(enableButton: retrospectiveTabButton, disableButton: evaluationTabButton, enableTabBar: retrospectiveTabBar, unableTabBar: evaluationTabBar)
        
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
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
            cell.delegate = self
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

// MARK: Setting
extension EvaluationVC {
    private func setWeekLabel() {
        weekLabel.font = .boldSystemFont(ofSize: 12)
        weekLabel.textAlignment = .center
        weekLabel.text = "20년 12월 3주"
    }
    
    private func setMenuTabButton() {
        evaluationTabButton.setTitleColor(selectedButtonColor, for: .normal)
        evaluationTabButton.setTitle("리포트", for: .normal)
        evaluationTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        retrospectiveTabButton.setTitleColor(originalButtonColor, for: .normal)
        retrospectiveTabButton.setTitle("회고", for: .normal)
        retrospectiveTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        retrospectiveTabBar.isHidden = true
    }
    
    private func setButtonState(enableButton: UIButton, disableButton: UIButton, enableTabBar: UIView, unableTabBar: UIView) {
        enableButton.setTitleColor(selectedButtonColor, for: .normal)
        disableButton.setTitleColor(originalButtonColor, for: .normal)
        enableTabBar.isHidden = false
        unableTabBar.isHidden = true
    }
    
    private func setCollectionViewDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
}

// MARK: NavigationViewController
extension EvaluationVC: TableViewTnsideCollectionViewDelegate {
    func cellTaped() {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "EvaluationDetailVC") as? EvaluationDetailVC else {
            return
        }
//        dvc.modalPresentationStyle = .fullScreen
//        self.present(dvc, animated: true, completion: nil)
//        self.makeNavigationPush(dvc)
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func topViewController() -> UIViewController? {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            if var viewController = window.rootViewController {
                while viewController.presentedViewController != nil {
                    viewController = viewController.presentedViewController!
                }
                return viewController
            }
        }
        return nil
    }
}

extension EvaluationVC: PushDelegate {
    func makeNavigationPush(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
