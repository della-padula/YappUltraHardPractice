//
//  ImageCollectionViewCell.swift
//  Practice2
//
//  Created by ITlearning on 2021/09/30.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let cellId = "ImageCell"
    private(set) var imageView = UIImageView()
    private let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingUI() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
