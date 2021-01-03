//
//  DetailRecordContentCVC.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/03.
//

import UIKit

class DetailRecordContentTVC: UITableViewCell {
    static let identifier = "DetailRecordContentTVC"
    
    @IBOutlet weak var recordCollectionView: UICollectionView!
    
    let list: [String] = ["안녕", "아티클 5개 읽기", "유노윤호 영상보면서 감상문쓰기", "100자 ㅅ쓰기", "안녕하세요", "아아아아아아 나도 방어회 먹고 싶어", "방구 뀐 놈이 성낸다", "저는 신윤아입니다", "블로그에 5쪽짜리 소설을 필사한 것 올리기(다음주 수요일까지는 마무리하자!! 아자!!", "동해물과 백두산이 마르고 닮도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이보전하세. 남산위에 저 소나무 철갑을 두른듯."]

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension DetailRecordContentTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailRecordCVC.identifier, for: indexPath as IndexPath) as! DetailRecordCVC
        cell.setConfigure(content: list[indexPath.item])
        return cell
    }
}

extension DetailRecordContentTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
}

extension DetailRecordContentTVC: DetailRecordLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let width = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = list[indexPath.item]
        label.sizeToFit()
        
        return label.frame.height + 120
    }
    
    private func setCollectionView() {
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
        recordCollectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        if let layout = recordCollectionView.collectionViewLayout as? DetailRecordLayout {
            layout.delegate = self
        }
    }
}
