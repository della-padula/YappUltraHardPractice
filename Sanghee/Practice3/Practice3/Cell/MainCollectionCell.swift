//
//  MainCollectionCell.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import SnapKit
import UIKit

class MainCollectionCell: UICollectionViewCell{
    static let identifier = "MainCollectionCell"
    
    var mainUnit: MainUnit? {
        didSet {
            setMainUnitView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMainUnitView(){
        let mainUnitView = MainUnitView()
        mainUnitView.mainUnit = mainUnit
        
        addSubview(mainUnitView)
        
        mainUnitView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
