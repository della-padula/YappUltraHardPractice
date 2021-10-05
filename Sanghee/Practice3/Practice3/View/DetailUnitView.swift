//
//  DetailUnitView.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/05.
//

import SnapKit
import UIKit

class DetailUnitView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
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
        
        layer.cornerRadius = 12
        backgroundColor = .systemGroupedBackground

        setLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabelTexts() {
        titleLabel.text = detailUnit?.title
        emojiLabel.text = detailUnit?.emoji
        paragraphLabel.text = detailUnit?.paragraph
    }
    
    private func setLabels() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(emojiLabel)
        containerView.addSubview(paragraphLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.right.equalToSuperview()
        }
        emojiLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        paragraphLabel.snp.makeConstraints {
            $0.top.equalTo(emojiLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview()
        }
    }
}
