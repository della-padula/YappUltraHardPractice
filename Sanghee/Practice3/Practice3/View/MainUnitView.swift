//
//  MainUnitView.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/03.
//

import SnapKit
import UIKit

class MainUnitView: UIView {
    var mainUnit: MainUnit? {
        didSet {
            setViewBackgroundColor()
            setLabelText()
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGray4
        return label
    }()
    
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
        setLabels()
        setEmojiLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewBackgroundColor() {
        backgroundColor = mainUnit?.backgroundColor
    }
    
    private func setLabelText() {
        titleLabel.text = mainUnit?.title
        subTitleLabel.text = mainUnit?.subTitle
        emojiLabel.text = mainUnit?.emoji
    }
    
    private func setView() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    private func setEmojiLabel() {
        addSubview(emojiLabel)
        
        emojiLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(140)
        }
    }
    
    private func setLabels() {
        addSubview(subTitleLabel)
        addSubview(titleLabel)
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(16)
        }
    }
}
