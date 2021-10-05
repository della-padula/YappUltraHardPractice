//
//  DetailCollectionCell.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/05.
//

import SnapKit
import UIKit

class DetailCollectionCell: UICollectionViewCell{
    static let identifier = "DetailCollectionCell"
    
    var detailUnit: DetailUnit? {
        didSet {
            setDetailUnitView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDetailUnitView(){
        let detailUnitView = DetailUnitView()
        detailUnitView.detailUnit = detailUnit
        
        addSubview(detailUnitView)
        
        detailUnitView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
