//
//  DetailRecordLayoutDelegate.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/09.
//

import UIKit

protocol DetailRecordLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForLabelAtIndexPath indexPath:IndexPath) -> CGFloat
}
