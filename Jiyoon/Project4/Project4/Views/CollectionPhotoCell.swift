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
    var imageView = UIImageView()
    var imageButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let photoImage = image
//        let img = UIImage(systemName: "image.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
//        let blueImg = img?.withTintColor(.blue)
//        imageButton.setImage(blueImg, for: .normal)
//        imageButton.addTarget(self, action: #selector(clickedPhoto), for: .touchUpInside)
//        print("image@@@",image)
//        let image2 = UIImage(named: )
        let button = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: image.size))
        button.setImage(image, for: .normal)
        self.addSubview(button)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.image = image
        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalTo(120)
            maker.height.equalTo(120)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    func clickedPhoto() {
        
    }
    
    
}
