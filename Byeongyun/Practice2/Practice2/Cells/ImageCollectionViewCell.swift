//
//  ImageCollectionViewCell.swift
//  Practice2
//
//  Created by ITlearning on 2021/09/30.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let cellId = "ImageCell"
    private let imageViewer = UIImageView()
    private let scrollView = UIScrollView()
    
    var settingImageView: UIImage? {
        didSet {
            guard let setting = settingImageView else { return }
            imageViewer.image = setting
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingUI() {
        contentView.addSubview(imageViewer)
        imageViewer.translatesAutoresizingMaskIntoConstraints = false
        imageViewer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageViewer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageViewer.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageViewer.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
