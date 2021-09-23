//
//  CollectionCell.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell{
    var cellTimeLabel = UILabel()
    var cellWeatherIcon = UIImageView()
    var cellTempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellTimeLabel.textColor = .white
        cellWeatherIcon.tintColor = .yellow
        cellTempLabel.textColor = .white
        
        self.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        self.cellTempLabel.text = "19"
        self.cellWeatherIcon.image = UIImage(systemName: "sun.max.fill")?.withTintColor(.yellow)
        
        addSubview(cellTimeLabel)
        addSubview(cellWeatherIcon)
        addSubview(cellTempLabel)
        
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
