//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//
import SnapKit
import UIKit

class WeatherCell: UITableViewCell {
    private var locationLabel = UILabel()
    private var tempLabel = UILabel()
    private var iconImage = UIImageView()
    private var line = UIView()
    static let identifier = "weatherTableViewCell"
    static var indexPath = 0
    private var locationsList: [String] = ["서울특별시", "대전시", "대구시", "부산시"]
    private var iconsList = [UIImage(systemName: "moon.stars")?.withTintColor(.white),
                UIImage(systemName: "sun.max")?.withTintColor(.white),
                UIImage(systemName: "sparkles")?.withTintColor(.white),
                UIImage(systemName: "cloud.sleet")?.withTintColor(.white)]
    private let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
    private var scaledIconsList: [UIImage] = []
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .black
        locationLabel.font = UIFont.systemFont(ofSize: 22)
        locationLabel.textColor = .white
        locationLabel.text = locationsList[WeatherCell.indexPath]
        tempLabel.font = UIFont.systemFont(ofSize: 30)
        tempLabel.textColor = .white
        line.backgroundColor = .white
        
        contentView.addSubview(locationLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(line)
        
        for icon in iconsList {
            let scaledIcon = renderer.image {
                draw in icon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            }
            scaledIconsList.append(scaledIcon)
        }
        iconImage.image = scaledIconsList[WeatherCell.indexPath]
        
        locationLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(20)
            maker.bottom.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-20)
            maker.bottom.equalToSuperview()
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
