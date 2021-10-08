//
//  DataCell.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import SnapKit
import UIKit

class DataCell: UICollectionViewCell{
    static let identifier = "DataCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(){
        let cellView = DataCellView()
        
        addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
