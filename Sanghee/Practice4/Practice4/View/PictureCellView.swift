//
//  PictureCellView.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/09.
//

import SnapKit
import UIKit

class PictureCellView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .systemGray
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "사진"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var picture: Picture? {
        didSet {
            setupPictureView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPictureView() {
        nameLabel.text = picture?.name
        
        if let url = picture?.url {
            let image = UIImage(contentsOfFile: url.path)
            imageView.image = image
        }
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.bottom.left.right.equalToSuperview()
        }
    }
}
