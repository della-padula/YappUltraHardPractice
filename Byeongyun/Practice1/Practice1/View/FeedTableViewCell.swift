//
//  FeedTableViewCell.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit

class FeedTableViewCell: UITableViewCell {
    
    static let cellId = "homeFeed"
    
    let userUploadImage = UIImageView()
    let userText = UILabel()
    let userName = UILabel()
    let userImage = UIImageView()
    let textUserName = UILabel()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userImage, userName])
        stackView.axis = .horizontal
        stackView.spacing = 10
        userImage.layer.cornerRadius = frame.height/2
        userImage.layer.borderWidth = 1
        userImage.clipsToBounds = true
        userImage.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(45)
            
            //$0.left.equalTo(self.snp.trailing).offset(-10)
            $0.leading.equalTo(5)
        }
        userName.font = UIFont.boldSystemFont(ofSize: 15)
        userName.snp.makeConstraints {
            //$0.centerX.equalTo(0)
            //$0.centerY.equalTo(0)
            $0.bottom.equalTo(-12)
        }
        
        stackView.alignment = .trailing
        
        return stackView
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textUserName, userText])
        stackView.axis = .horizontal
        stackView.spacing = 10
        textUserName.font = UIFont.boldSystemFont(ofSize: 15)
        textUserName.snp.makeConstraints {
            $0.leading.equalTo(10)
        }
        
        userText.font = UIFont.systemFont(ofSize: 15)
        
        stackView.alignment = .trailing
        
        return stackView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingUI() {
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.height.equalTo(55)
            //$0.bottom.equalTo(20)
        }
        
        self.addSubview(userUploadImage)
        userUploadImage.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-40)
            //$0.width.equalTo(60)
            $0.height.equalTo(300)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
        
        
        self.addSubview(textStackView)
        textStackView.snp.makeConstraints {
            $0.top.equalTo(userUploadImage.snp.bottom)
            $0.height.equalTo(30)
            
        }
        
        
    }
}
