//
//  FileUrlCell.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import SnapKit
import UIKit

protocol ButtonDelegate {
    func showAlert(index: Int)
}

class FileUrlCell: UITableViewCell {
    
    var delegate: ButtonDelegate?
    static let identifier = "FileUrlCell"
    
    let cellView = UIView()
    let titleLabel = UILabel()
    let downloadButton = UIButton()
    var index: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        downloadButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        self.delegate?.showAlert(index: index)
    }
    
    private func layout() {
        let iconView = UIImageView(image: UIImage(systemName: "doc"))
        downloadButton.setTitle("다운로드", for: .normal)
        
        self.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(8)
        }
        
        cellView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(24)
        }
        
        cellView.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(8)
            make.width.equalTo(80)
        }
        
        cellView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(iconView.snp.right).offset(16)
            make.right.equalTo(downloadButton.snp.left).offset(16)
        }

        self.selectionStyle = .none
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        downloadButton.setTitleColor(.systemBlue, for: .normal)
        downloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
}
