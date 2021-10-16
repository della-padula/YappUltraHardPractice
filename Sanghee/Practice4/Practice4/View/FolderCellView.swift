//
//  FolderCellView.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/09.
//

import SnapKit
import UIKit

class FolderCellView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let folderImage: UIImageView = {
        let image = UIImage(systemName: "folder")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 폴더"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var folder: Folder? {
        didSet {
            nameLabel.text = folder?.name
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
        containerView.addSubview(folderImage)
        containerView.addSubview(nameLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        folderImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(26)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(folderImage.snp.bottom).offset(6)
            $0.bottom.left.right.equalToSuperview()
        }
    }
}
