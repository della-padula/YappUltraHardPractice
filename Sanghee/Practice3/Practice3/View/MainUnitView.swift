//
//  MainUnitView.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/03.
//

import SnapKit
import UIKit

class MainUnitView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGray4
        return label
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100)
        label.textAlignment = .center
        return label
    }()
    
    var mainUnit: MainUnit? {
        didSet {
            setViewBackgroundColor()
            setLabelTexts()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 12
        
        setLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewBackgroundColor() {
        backgroundColor = mainUnit?.backgroundColor
    }
    
    private func setLabelTexts() {
        titleLabel.text = mainUnit?.title
        subTitleLabel.text = mainUnit?.subTitle
        emojiLabel.text = mainUnit?.emoji
    }
    
    private func setLabels() {
        addSubview(containerView)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(emojiLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
        }
        
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(56)
            $0.centerX.equalToSuperview()
        }
    }
}
