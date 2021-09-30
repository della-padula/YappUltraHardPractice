//
//  DetaillmageCollectionViewCell.swift
//  Practice2
//
//  Created by ITlearning on 2021/10/01.
//

import UIKit

class DetaillmageCollectionViewCell: UICollectionViewCell {
    static let cellId = "DetailCell"
    private let imageViewer = UIImageView()
    private let scrollView = UIScrollView()
    var settingImageView: UIImage? {
        didSet {
            guard let setting = settingImageView else { return }
            imageViewer.image = setting
            imageViewer.contentMode = .scaleAspectFit
            // imageViewer.contentMode = .center
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        self.scrollView.delegate = self
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingUI() {
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.addSubview(imageViewer)
        imageViewer.translatesAutoresizingMaskIntoConstraints = false
        imageViewer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageViewer.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        imageViewer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageViewer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageViewer.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
    }
    
}

extension DetaillmageCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageViewer
    }
    
}
