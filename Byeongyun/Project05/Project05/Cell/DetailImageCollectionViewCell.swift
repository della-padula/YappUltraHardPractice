//
//  DetailImageCollectionViewCell.swift
//  Project05
//
//  Created by ITlearning on 2021/10/09.
//

import UIKit
import SnapKit

class DetailImageCollectionViewCell: UICollectionViewCell {
    static let cellId = "DetailCell"
    private let scrollView = UIScrollView()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
    }()
    
    var detailImage: URL? {
        didSet {
            guard let image = detailImage else { return }
            guard let data = try? Data(contentsOf: image) else { return }
            imageView.image = UIImage(data: data)
        }
    }
    
    var scrollZoomSize: CGFloat? {
        didSet {
            guard let setting = scrollZoomSize else { return }
            scrollView.setZoomScale(setting, animated: true)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureZoomSize()
        settingUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureZoomSize() {
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        self.scrollView.delegate = self
    }
    
    private func settingUI() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(scrollView.snp.centerX)
            $0.centerY.equalTo(scrollView.snp.centerY)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.height.equalTo(scrollView.snp.height)
        }
    }
    
}

extension DetailImageCollectionViewCell: UIScrollViewDelegate {
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
