//
//  DetaillmageCollectionViewCell.swift
//  Practice2
//
//  Created by ITlearning on 2021/10/01.
//

import UIKit

class DetaillmageCollectionViewCell: UICollectionViewCell {
    static let cellId = "DetailCell"
    private let scrollView = UIScrollView()
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var scrollZoomSize: CGFloat? {
        didSet {
            guard let setting = scrollZoomSize else { return }
            scrollView.setZoomScale(setting, animated: true)
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
    
    private func settingUI() {
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
}

extension DetaillmageCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 0.1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                let ratio = ratioW < ratioH ? ratioW:ratioH
                let newWidth = image.size.width*ratio
                let newHeight = image.size.height*ratio
                let left = 0.5 * (newWidth * scrollView.zoomScale > imageView.frame.width ? (newWidth - imageView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > imageView.frame.height ? (newHeight - imageView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }
    }
    
}
