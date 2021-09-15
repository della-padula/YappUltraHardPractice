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
    let likeStatus = UILabel()
    
    // 위에 유저 이름이랑 사진 스택 뷰
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
    
    
    // 아래 텍스트 창의 스택 뷰
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textUserName, userText])
        stackView.axis = .horizontal
        stackView.spacing = 1
        textUserName.font = UIFont.boldSystemFont(ofSize: 15)
        textUserName.snp.makeConstraints {
            $0.leading.equalTo(15)
            //$0.height.equalTo(30)
        }
        
        userText.font = UIFont.systemFont(ofSize: 15)
        
        stackView.alignment = .fill
        
        return stackView
    }()
    
    
    // 좋아요 정보와 함께 묶여있는 스택 뷰 (얘는 vertical)
    lazy var likeSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeStatus, textStackView])
        likeStatus.font = UIFont.systemFont(ofSize: 15)
        stackView.axis = .vertical
        //stackView.spacing = 1
        likeStatus.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.leading.equalTo(10)
        }
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell UI 세팅
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
            //$0.bottom.equalTo(self.snp.bottom).offset(-30)
            //$0.width.equalTo(60)
            $0.height.equalTo(300)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
        
        
        self.addSubview(likeSV)
        likeSV.snp.makeConstraints {
            $0.top.equalTo(userUploadImage.snp.bottom)
            $0.height.equalTo(70)
            $0.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        
    }
}
