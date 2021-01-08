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
    @IBOutlet weak var noRecordView: UIView!
    
    lazy var notifyLabel: UILabel = {
        let notifyLabel = UILabel()
        notifyLabel.translatesAutoresizingMaskIntoConstraints = false
        return notifyLabel
    }()
    
    var list: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
        setNoDataView()
        setNoRecordView()
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
        cell.setLabelData(content: list[indexPath.item])
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
        label.font = .myBoldSystemFont(ofSize: 16)
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
    
    private func setNoDataView() {
        if list.isEmpty {
            recordCollectionView.isHidden = true
            noRecordView.isHidden = false
        } else {
            recordCollectionView.isHidden = false
            noRecordView.isHidden = true
        }
    }
    
    private func setNoRecordView() {
        noRecordView.addSubview(notifyLabel)
        
        notifyLabel.bottomAnchor.constraint(equalTo: noRecordView.bottomAnchor, constant: -132).isActive = true
        notifyLabel.centerXAnchor.constraint(equalTo: noRecordView.centerXAnchor).isActive = true
        notifyLabel.font = .myRegularSystemFont(ofSize: 12)
        notifyLabel.textAlignment = .center
        notifyLabel.numberOfLines = 0
        notifyLabel.textColor = .mainGray
        notifyLabel.text = "이 날에는 키워드가 없어요.😢"
    }
}
