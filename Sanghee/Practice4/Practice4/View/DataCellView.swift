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
        imageView.tintColor = .systemGray5
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
            $0.bottom.equalToSuperview().inset(32)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func setupFolderView() {
        guard let folder = folder else { return }
        
        imageView.image = UIImage(systemName: "folder")
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.text = folder.name
    }
    
    private func setupPictureView() {
        guard let picture = picture else { return }
        
        imageView.image = UIImage(contentsOfFile: picture.url.path)
        imageView.contentMode = .scaleToFill
        
        nameLabel.text = picture.name
    }
}
