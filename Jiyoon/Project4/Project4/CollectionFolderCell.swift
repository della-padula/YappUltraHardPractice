//
//  CollectionFolderCell.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit
class CollectionFolderCell: UICollectionViewCell {
    let config = UIImage.SymbolConfiguration(pointSize: 60)
    let titleLabel = UILabel()
    static let identifier = "collectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let folderImage = UIImage(systemName: "folder", withConfiguration: config)
        let blueFolderImage = folderImage?.withTintColor(.systemBlue)
        let imageView = UIImageView(image: blueFolderImage)
        self.addSubview(imageView)
        setTitleLabel()
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-20)
        }
    }
    func setTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.text = "폴더 1"
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
