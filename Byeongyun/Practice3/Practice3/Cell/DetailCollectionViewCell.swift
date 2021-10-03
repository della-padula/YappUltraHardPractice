//
//  DetailCollectionViewCell.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/04.
//

import UIKit
import SnapKit
class DetailCollectionViewCell: UICollectionViewCell {
    
    private let appExplainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var explainString: String? {
        didSet {
            appExplainLabel.text = explainString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(appExplainLabel)
        appExplainLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(20)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            
        }
    }
}
