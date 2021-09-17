//
//  CollectionCell.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell{
    var cellTimeLabel : UILabel
    var cellWeatherIcon : UIImageView
    var cellTempLabel : UILabel
    
    override init(frame: CGRect) {
        self.cellTimeLabel = UILabel()
        cellTimeLabel.textColor = .white
        self.cellWeatherIcon = UIImageView()
        cellWeatherIcon.tintColor = .yellow
        self.cellTempLabel = UILabel()
        cellTempLabel.textColor = .white
        super.init(frame: frame)
        
        self.addSubview(cellTimeLabel)
        self.addSubview(cellWeatherIcon)
        self.addSubview(cellTempLabel)
        
        cellTimeLabel.snp.makeConstraints { maker in
            maker.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(10)
            maker.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
        }
        cellWeatherIcon.snp.makeConstraints { maker in
            maker.top.equalTo(cellTimeLabel.safeAreaLayoutGuide.snp.bottom).offset(20)
            maker.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
        }
        cellTempLabel.snp.makeConstraints { maker in
            maker.top.equalTo(cellWeatherIcon.safeAreaLayoutGuide.snp.bottom).offset(20)
            maker.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
        }
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
