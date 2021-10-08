//
//  MainTableViewCell.swift
//  Project05
//
//  Created by ITlearning on 2021/10/08.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let cellId = "FolderCell"
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "app01")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = UIImage(named: "app01")?.accessibilityIdentifier
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        return label
    }()
    
    var update: Test? {
        didSet {
            guard let update = update else { return }
            leftImageView.image = update.image
            centerLabel.text = update.name
        }
    }
    
    var leftImage: UIImage? {
        didSet {
            guard let image = leftImage else { return }
            leftImageView.image = image
        }
    }
    
    var midLabel: String? {
        didSet {
            guard let text = midLabel else { return }
            centerLabel.text = text
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.width.equalTo(50)
            $0.height.equalTo(55)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        addSubview(centerLabel)
        centerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(leftImageView.snp.leading).offset(60)
            
        }
    }
    
}
