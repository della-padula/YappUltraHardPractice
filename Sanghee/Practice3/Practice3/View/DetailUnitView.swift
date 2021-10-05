//
//  DetailUnitView.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/05.
//

import SnapKit
import UIKit

class DetailUnitView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    private let paragraphLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    var detailUnit: DetailUnit? {
        didSet {
            setLabelTexts()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGroupedBackground

        setLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabelTexts() {
        titleLabel.text = detailUnit?.title
        subTitleLabel.text = detailUnit?.subTitle
        emojiLabel.text = detailUnit?.emoji
        paragraphLabel.text = detailUnit?.paragraph
    }
    
    private func setLabels() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(emojiLabel)
        addSubview(paragraphLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
        }
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        paragraphLabel.snp.makeConstraints {
            $0.top.equalTo(emojiLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
}
