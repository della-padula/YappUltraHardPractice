//
//  MainViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    private let mainPresenter = MainPresenter()
    private var timeLabel = UILabel()
    private var titleLabel = UILabel()
    private var profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setHeader()
        setMainUnitView()
    }
}

extension MainViewController: MainView {
    func setHeader() {
        timeLabel = {
            let label = UILabel()
            label.text = "10월 3일 일요일"
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .systemGray
            return label
        }()
        titleLabel = {
            let label = UILabel()
            label.text = "투데이"
            label.font = UIFont.boldSystemFont(ofSize: 36)
            return label
        }()
        profileImageView = {
            let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
            return imageView
        }()
        
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
    
    func setMainUnitView() {
        guard let mainUnitView = mainPresenter.mainUnitViews.first else { return }
        
        view.addSubview(mainUnitView)
        
        mainUnitView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(400)
        }
    }
}
