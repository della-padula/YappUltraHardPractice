//
//  GameCollectionViewCell.swift
//  UltraProject1
//
//  Created by ITlearning on 2021/09/27.
//

import UIKit
import SnapKit

class GameCollectionViewCell: UICollectionViewCell {
    static let cellId = "GameCell"
    let numberLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingUI() {
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
        }
    }
}
