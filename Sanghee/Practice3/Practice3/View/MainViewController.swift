//
//  MainViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "10월 3일 일요일"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHeader()
    }
    
    private func configureHeader() {
        view.addSubview(timeLabel)
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.left.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(16)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.right.equalToSuperview().inset(16)
            $0.width.height.equalTo(36)
        }
    }
}
