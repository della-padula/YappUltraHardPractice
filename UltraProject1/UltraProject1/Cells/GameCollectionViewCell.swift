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
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var number: Int? {
        didSet {
            guard let number = number else { return }
            numberLabel.text = "\(number)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            
        }
    }
}
