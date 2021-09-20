//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//
import SnapKit
import UIKit

class WeatherCell: UITableViewCell{
    var locationLabel = UILabel()
    var tempLabel = UILabel()
    var iconImage = UIImageView()
    var line = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        locationLabel.font = UIFont.systemFont(ofSize: 22)
        locationLabel.textColor = .white
        
        tempLabel.font = UIFont.systemFont(ofSize: 30)
        tempLabel.textColor = .white
        
        self.iconImage = UIImageView()
        self.line = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 1))
        line.backgroundColor = .white
        super.init(style: .default, reuseIdentifier: "cell")
        
        contentView.addSubview(locationLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(line)
        
        locationLabel.snp.makeConstraints { maker in
            maker.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            maker.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(20)
            maker.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
            
        }
        tempLabel.snp.makeConstraints { maker in
            maker.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            maker.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-20)
            maker.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
        }
        iconImage.snp.makeConstraints { maker in
            maker.trailing.equalTo(tempLabel.safeAreaLayoutGuide.snp.leading).offset(-20)
            maker.centerY.equalTo(contentView.snp.centerY)
        }
        line.snp.makeConstraints { maker in
            maker.bottom.equalTo(contentView.snp.bottom)
            maker.leading.equalTo(contentView.snp.leading)
            maker.trailing.equalTo(contentView.snp.trailing)
            maker.height.equalTo(1)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
