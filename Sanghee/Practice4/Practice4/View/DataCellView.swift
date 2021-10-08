//
//  DataCellView.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import SnapKit
import UIKit

class DataCellView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    private let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80)
        label.textAlignment = .center
        return label
    }()
    private let fileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var folder: Folder? {
        didSet {
            setupFolder()
        }
    }
    var picture: Picture? {
        didSet {
            setupPicture()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFolder() {
        iconLabel.text = "📁"
        fileLabel.text = folder?.name
    }
    private func setupPicture() {
        iconLabel.text = "🌃"
        fileLabel.text = picture?.name
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(iconLabel)
        containerView.addSubview(fileLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        iconLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        fileLabel.snp.makeConstraints {
            $0.top.equalTo(iconLabel.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
    }
}
