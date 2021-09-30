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
    let scrollView = UIScrollView()
    
    var settingImageView: UIImage? {
        didSet {
            guard let setting = settingImageView else { return }
            imageViewer.image = setting
            imageViewer.contentMode = .scaleAspectFit
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
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 0.1 {
            if let image = imageViewer.image {
                let ratioW = imageViewer.frame.width / image.size.width
                let ratioH = imageViewer.frame.height / image.size.height
                let ratio = ratioW < ratioH ? ratioW:ratioH
                let newWidth = image.size.width*ratio
                let newHeight = image.size.height*ratio
                let left = 0.5 * (newWidth * scrollView.zoomScale > imageViewer.frame.width ? (newWidth - imageViewer.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > imageViewer.frame.height ? (newHeight - imageViewer.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }
    }
    
}
