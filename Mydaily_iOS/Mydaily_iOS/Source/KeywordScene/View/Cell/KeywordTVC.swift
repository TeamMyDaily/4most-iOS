//
//  KeywordTVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2020/12/31.
//

import UIKit

class KeywordTVC: UITableViewCell {
    static let identifier = "KeywordTVC"
    //var collectionItemCount = 0
    var keywordList: [String] = []
    
    @IBOutlet var keywordCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setKeywordList(list: [String]){
        keywordList = list
        print(keywordList.count)
    }
  
    func setCollectionViewDelegate(){
        keywordCollectionView.dataSource = self
        keywordCollectionView.delegate = self
        keywordCollectionView.register(UINib(nibName: "KeywordCVC", bundle: .main), forCellWithReuseIdentifier: KeywordCVC.identifier)
    }
}


extension KeywordTVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCVC.identifier, for: indexPath) as? KeywordCVC else {
            return UICollectionViewCell()
        }
        
        cell.setKeywordButton(text: keywordList[indexPath.row])
        return cell
        
    }
}

extension KeywordTVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCVC.identifier, for: indexPath) as? KeywordCVC else {
            return CGSize()
        }

        let buttonWidth = (keywordList[indexPath.row].count) * 27
        
        return CGSize(width: buttonWidth, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 17, bottom: 40, right: 59)
    }
}
