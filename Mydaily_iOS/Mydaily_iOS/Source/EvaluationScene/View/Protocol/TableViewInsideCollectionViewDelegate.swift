//
//  TableViewInsideCollectionViewDelegate.swift
//  Mydaily_iOS
//
//  Created by SHIN YOON AH on 2021/01/05.
//

import Foundation

protocol TableViewInsideCollectionViewDelegate: class {
    func cellTapedEvaluation(dvc: EvaluationDetailVC)
    func cellTapedRetrospective(dvc: RetrospectiveWriteVC)
}
