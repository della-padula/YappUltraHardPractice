//
//  FileUrlCell.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import SnapKit
import UIKit

protocol ButtonDelegate: AnyObject {
    func showAlert(index: Int)
}

class FileUrlCell: UITableViewCell {
    weak var delegate: ButtonDelegate?
    static let identifier = "FileUrlCell"
    var index: Int = 0
    var fileUrl: FileUrl? {
        didSet {
            layout()
        }
    }
    
    private let cellView = UIView()
    private let titleLabel = UILabel()
    private let downloadButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        self.addSubview(cellView)
        cellView.addSubview(iconView)
        cellView.addSubview(downloadButton)
        cellView.addSubview(titleLabel)
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(6)
        }
        iconView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(22)
        }
        downloadButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.right.equalToSuperview()
            make.width.equalTo(80)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(iconView.snp.right).offset(12)
            make.right.equalTo(downloadButton.snp.left).offset(12)
        }

        self.selectionStyle = .none
        titleLabel.text = fileUrl?.title
        downloadButton.setTitle("다운로드", for: .normal)
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Constants.Color.blue.withAlphaComponent(0.8)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        downloadButton.setTitleColor(Constants.Color.blue, for: .normal)
        downloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
}