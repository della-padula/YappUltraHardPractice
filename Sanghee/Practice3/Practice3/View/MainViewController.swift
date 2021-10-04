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
    private var scrollView = UIScrollView()
    private var timeLabel = UILabel()
    private var titleLabel = UILabel()
    private var profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setScrollView()
        setHeader()
        setMainUnitViews()
    }
}

extension MainViewController: MainView {
    func setScrollView() {
        scrollView.backgroundColor = .systemGroupedBackground
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
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
        
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(profileImageView)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview()
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.right.equalToSuperview()
            $0.width.height.equalTo(36)
        }
    }
    
    func setMainUnitViews() {
        let mainUnits = mainPresenter.mainUnits
        
        for (index, mainUnit) in mainUnits.enumerated() {
            let unitViewHeight = 400
            let space = 36
            let mainUnitView = MainUnitView()
            mainUnitView.mainUnit = mainUnit

            scrollView.addSubview(mainUnitView)
            
            mainUnitView.snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(unitViewHeight)
                $0.top.equalTo(titleLabel.snp.bottom).offset((unitViewHeight + space) * index + 16)
            }
            
            if index == (mainUnits.count - 1) {
                mainUnitView.snp.makeConstraints {
                    $0.bottom.equalToSuperview()
                }
            }
        }
    }
}
