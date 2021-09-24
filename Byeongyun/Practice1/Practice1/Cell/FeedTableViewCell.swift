//
//  FeedTableViewCell.swift
//  Practice1
//  메인 뷰 테이블 뷰 셀
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit
class FeedTableViewCell: UITableViewCell {
    static let cellId = "homeFeed"
    private let userUploadImage = UIImageView()
    private let userProfileImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let textUserNameLabel = UILabel()
    private let likeStatusLabel = UILabel()
    private let userTextLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
        
    }()
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    // Property Observer
    
    var uploadImage: UIImage? {
        get {
            return userUploadImage.image
        }
        set {
            userUploadImage.image = newValue
        }
    }
    
    var profileImage: UIImage? {
        get {
            return userProfileImageView.image
        }
        set {
            userProfileImageView.image = newValue
        }
    }
    
    var titleNameText: String? {
        get {
            return userNameLabel.text
        }
        set {
            userNameLabel.text = newValue
        }
    }
    
    var writeText: String? {
        get {
            return userTextLabel.text
        }
        set {
            userTextLabel.text = newValue
        }
    }
    
    var feedNameText: String? {
        get {
            return textUserNameLabel.text
        }
        set {
            textUserNameLabel.text = newValue
        }
    }
    
    var likeText: String? {
        get {
            return likeStatusLabel.text
        }
        set {
            likeStatusLabel.text = newValue
        }
    }
    
    var dateNumber: String? {
        get {
            return dateLabel.text
        }
        set {
            dateLabel.text = newValue
        }
    }
    
    /*
    var cellDataSetting: Feed? {
        didSet {
            userUploadImage.image = cellDataSetting?.uploadImage
            userProfileImageView.image = cellDataSetting?.userImage
            userNameLabel.text = cellDataSetting?.userName
            textUserNameLabel.text = cellDataSetting?.userName
            userTextLabel.text = cellDataSetting?.text
            likeStatusLabel.text = "\(cellDataSetting?.like ?? 0) 명이 좋아합니다."
            let formatter = DateFormatter()
            formatter.dateFormat = "MM월 dd일 HH:mm"
            let currentString = formatter.string(from: cellDataSetting?.time ?? Date(timeIntervalSinceNow: Date.timeIntervalBetween1970AndReferenceDate))
            dateLabel.text = currentString
        }
    }
     */
    
    // 위에 유저 이름이랑 사진 스택 뷰
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userProfileImageView, userNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        userProfileImageView.layer.cornerRadius = frame.height/2
        userProfileImageView.layer.borderWidth = 1
        userProfileImageView.clipsToBounds = true
        userProfileImageView.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(45)
            $0.leading.equalTo(5)
        }
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(-12)
        }
        stackView.alignment = .trailing
        return stackView
    }()
    
    // 아래 텍스트 창의 스택 뷰
    private lazy var inputTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textUserNameLabel, userTextLabel])
        stackView.axis = .horizontal
        stackView.spacing = 1
        textUserNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        userTextLabel.snp.makeConstraints {
            $0.left.equalTo(30)
            $0.width.equalTo(300)
            $0.bottom.equalTo(0)
            $0.right.equalTo(-10)
        }
        userTextLabel.font = UIFont.systemFont(ofSize: 15)
        stackView.alignment = .fill
        return stackView
    }()
    
    // 좋아요 정보와 함께 묶여있는 스택 뷰 (얘는 vertical)
    private lazy var likeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeStatusLabel, inputTextStackView])
        likeStatusLabel.font = UIFont.systemFont(ofSize: 15)
        stackView.axis = .vertical
        likeStatusLabel.snp.makeConstraints {
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
        // 셀 상단의 유저 사진과 이름
        addSubview(userStackView)
        userStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.height.equalTo(55)
        }
        // 셀 중앙에 위치한 업로드한 사진
        addSubview(userUploadImage)
        userUploadImage.snp.makeConstraints {
            $0.top.equalTo(userStackView.snp.bottom).offset(10)
            
            $0.height.equalTo(360)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
        // 셀 하단에 위치한 하트 개수와 유저이름, 내용
        addSubview(likeStackView)
        likeStackView.snp.makeConstraints {
            $0.top.equalTo(userUploadImage.snp.bottom)
            $0.height.equalTo(70)
            $0.bottom.equalTo(self.snp.bottom).offset(-25)
        }
        // 업로드 요일과 시간
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-5)
            $0.leading.equalTo(self.snp.leading).offset(10)
        }
    }
}
