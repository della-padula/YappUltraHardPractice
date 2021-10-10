//
//  MainTableViewCell.swift
//  Project05
//
//  Created by ITlearning on 2021/10/08.
//

import UIKit
import SnapKit
class TableViewCell: UITableViewCell {
    
    static let cellId = "FolderCell"
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = UIImage(named: "app01")?.accessibilityIdentifier
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        return label
    }()
    
    var update: Folder? {
        didSet {
            guard let update = update else { return }
            leftImageView.image = UIImage(systemName: "folder.fill")
            centerLabel.text = update.name
        }
    }
    
    var leftImage: URL? {
        didSet {
            guard let image = leftImage else { return }
            guard let data = NSData(contentsOf: image) else { return }
            let im = UIImage(data: data as Data)
            leftImageView.image = im
        }
    }
    
    var midLabel: String? {
        didSet {
            guard let text = midLabel else { return }
            centerLabel.text = text
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.width.equalTo(50)
            $0.height.equalTo(55)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        addSubview(centerLabel)
        centerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(leftImageView.snp.leading).offset(60)
        }
    }
}
