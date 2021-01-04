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
    
    var list: [String] = ["IT 기술에 관한 아티클 정리하기", "글감수집하기", "아티클 리뷰하기", "20글자를써보자20글자를써보자20글자", "mydaily==4most","12345678910111213141", "IT 기술에 관한 아티클 정리하기"]

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
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 16)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
}

extension DetailRecordContentTVC: DetailRecordLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let width = (collectionView.bounds.size.width - (collectionView.contentInset.left + collectionView.contentInset.right + 16 + 16 + 30)) / 2 - 30
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = list[indexPath.item]
        label.preferredMaxLayoutWidth = width
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.contentMode = .scaleToFill
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        
        let calculateHeight = label.intrinsicContentSize.height + 120
        
        return calculateHeight
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
