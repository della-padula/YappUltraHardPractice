//
//  CollectionPhotoCell.swift
//  Project4
//
//  Created by 박지윤 on 2021/10/09.
//

import Foundation
import UIKit
class CollectionPhotoCell: UICollectionViewCell {
    let config = UIImage.SymbolConfiguration(pointSize: 55)
    static let identifier = "collectionPhotoCell"
    var image = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let photoImage = image

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = image
        
        addSubview(imageView)
//        backgroundColor = .black
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    func a() {
        
    }
    
    
}
