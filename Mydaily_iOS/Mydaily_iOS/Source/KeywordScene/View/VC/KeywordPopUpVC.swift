//
//  KeywordPopUpVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2020/12/30.
//

import UIKit

class KeywordPopUpVC: UIViewController {
    static let identifier = "KeywordPopUpVC"
    
    @IBOutlet var contentPageContol: UIPageControl!
    @IBOutlet var contentCollectionView: UICollectionView!
    
    @IBOutlet var helpLabel: UILabel!
    @IBOutlet var skipButton: UIButton!

    
    var isOnBoard = false
    var onBoardText:[String] = ["내 삶의 지향점이 될\n가치관을 정해보세요",
                               "가치관에 가까워지기 위한\n일상의 행동을 기록해보세요",
                               "한 주간의 행동을 회고하면서\n더 나은 내일을 꿈꿔보세요"]
    
    var onBoardImageList: [UIImage] = [UIImage(named: "iamge_explain_01")!,
                                       UIImage(named: "iamge_explain_02")!,
                                       UIImage(named: "iamge_explain_03")!]
    
    var question: [String] = ["당신이 선망하는 사람은 누구인가요?\n 그 이유는 무엇인가요?",
                              "당신의 완벽한 하루를 상상해 보세요!\n 어떤 것을 하고 있나요?",
                              "남들에게 어떤 사람으로\n 기억되고 싶으신가요?"]
    var answer: [String] = ["스티브 잡스\n 우리가 이룬 것 만큼 이루지 못한 것도\n 자랑스럽습니다 라고 말하는 자신감",
                            "계획한 대로 하루를 분단위로 쪼개서 바쁘게 살았을 때\n 하루를 알차게 보냈다는 뿌듯함에서 오는 자랑스러움\n 그것이 나의 완벽한 하루다",
                            "항상 가식없는 사람, 미담이 가득한 사람이 되고 싶다.\n 어려운 일이라는 것을 알고 누군가를 나를 싫어하는 사람이\n 있을테지만 싫어 할 수가 없는 진정성 있는 사람이 되고싶다"]

    var popUpImageList: [UIImage] = [UIImage(named: "iamge_explain_01")!,
                                     UIImage(named: "iamge_explain_02")!,
                                     UIImage(named: "iamge_explain_03")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        if isOnBoard{
            helpLabel.isHidden = true
        }else{
            helpLabel.isHidden = false
        }
    }
    
    func setDelegate(){
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(UINib(nibName: "ContentCVC", bundle: .main), forCellWithReuseIdentifier: ContentCVC.identifier)
    }
    
    func checkOnBoard(check: Bool){
        isOnBoard = check
    }
    
    @IBAction func backToKeywordSetting(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
}

extension KeywordPopUpVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCVC.identifier, for: indexPath) as? ContentCVC else{
            return UICollectionViewCell()
        }
        
        if isOnBoard{
            cell.setImage(image: onBoardImageList[indexPath.row])
            cell.setLabel(question: question[indexPath.row], answer: "")
        }else{
            cell.setImage(image: popUpImageList[indexPath.row])
            cell.setLabel(question: question[indexPath.row], answer: answer[indexPath.row])
            
        }
        return cell
    }
    
}

extension KeywordPopUpVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
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


extension KeywordPopUpVC{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var currentPage: Int
        currentPage = Int(scrollView.contentOffset.x) /
            Int(scrollView.frame.width)
        
        contentPageContol.currentPage = currentPage
        
        if(currentPage == 2){
            skipButton.setTitle("알겠어요", for: .normal)
            skipButton.setTitleColor(.white, for: .normal)
            skipButton.titleLabel?.font =  UIFont(name: "System-Heavy", size: 18.0)
            skipButton.layer.cornerRadius = 15
            skipButton.backgroundColor = UIColor.mainOrange
            
        }
    }
}
