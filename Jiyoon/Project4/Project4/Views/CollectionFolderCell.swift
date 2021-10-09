//
//  CollectionFolderCell.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit
class CollectionFolderCell: UICollectionViewCell {
    let config = UIImage.SymbolConfiguration(pointSize: 55)
    let titleLabel = UILabel()
    static let identifier = "collectionCell"
    var title: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let folderImage = UIImage(systemName: "folder.fill", withConfiguration: config)
        let blueFolderImage = folderImage?.withTintColor(.systemBlue)

        let folderButton = UIButton()
        folderButton.addTarget(self, action: #selector(a), for: .touchUpInside)
        folderButton.setImage(blueFolderImage, for: .normal)
        self.addSubview(folderButton)
        setTitleLabel()
        folderButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-20)
        }
    }
    
    func setTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.text = title
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    func a() {
        
    }
    
    
}
