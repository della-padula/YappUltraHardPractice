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
    
    private let cellView = DataCellView()
    
    var folder: Folder? {
        didSet {
            cellView.folder = folder
        }
    }
    var picture: Picture? {
        didSet {
            cellView.picture = picture
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(){
        addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
