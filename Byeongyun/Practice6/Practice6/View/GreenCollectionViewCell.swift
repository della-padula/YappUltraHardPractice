//
//  GreenCollectionViewCell.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/15.
//

import UIKit
import SnapKit

class GreenCollectionViewCell: UICollectionViewCell {
    static let cellId = "greenCell"
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5

        return view
    }()

    var changeColor: CGFloat? {
        didSet {
            guard let num = changeColor else { return }
            if 0 < num && num <= 4 {
                greenView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            } else if num > 5 {
                greenView.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        contentView.addSubview(greenView)
        greenView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}
