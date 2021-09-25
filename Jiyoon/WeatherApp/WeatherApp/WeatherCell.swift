//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//
import SnapKit
import UIKit

class WeatherCell: UITableViewCell {
    public var locationLabel = UILabel()
    public var tempLabel = UILabel()
    public var iconImage = UIImageView()
    public var line = UIView()
    static let identifier = "weatherTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        locationLabel.font = UIFont.systemFont(ofSize: 22)
        locationLabel.textColor = .white
        tempLabel.font = UIFont.systemFont(ofSize: 30)
        tempLabel.textColor = .white
        line.backgroundColor = .white
        
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
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(1)
            maker.width.equalTo(300)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
