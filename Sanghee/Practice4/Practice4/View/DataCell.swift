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
    
    private let dataCellView = DataCellView()
    
    var folder: Folder? {
        didSet {
            dataCellView.folder = folder
            setupCellView()
        }
    }
    var picture: Picture? {
        didSet {
            dataCellView.picture = picture
            setupCellView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellView() {
        addSubview(dataCellView)
        
        dataCellView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
