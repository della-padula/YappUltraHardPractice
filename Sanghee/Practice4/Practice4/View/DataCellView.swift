//
//  DataCellView.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/09.
//

import SnapKit
import UIKit

class DataCellView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "folder")
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var folder: Folder? {
        didSet {
            setupFolderView()
        }
    }
    
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
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(26)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.bottom.left.right.equalToSuperview()
        }
    }
    
    private func setupFolderView() {
        guard let folder = folder else { return }
        
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.text = folder.name
    }
    
    private func setupPictureView() {
        guard let picture = picture else { return }
        
        let image = UIImage(contentsOfFile: picture.url.path)
        imageView.image = image
        
        nameLabel.text = picture.name
    }
}
