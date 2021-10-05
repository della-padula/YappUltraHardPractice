//
//  MainUnitView.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/03.
//

import SnapKit
import UIKit

class MainUnitView: UIView {
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

        setView()
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
    
    private func setView() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    private func setLabels() {
        addSubview(subTitleLabel)
        addSubview(titleLabel)
        addSubview(emojiLabel)
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
        }
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
        }
    }
}
