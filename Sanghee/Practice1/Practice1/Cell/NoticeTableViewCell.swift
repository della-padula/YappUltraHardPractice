//
//  NoticeTableViewCell.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import SnapKit
import UIKit

class NoticeTableViewCell: UITableViewCell {
    static let identifier = "NoticeCell"
    
    private let cellView = UIView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    
    var notice: Notice? {
        didSet {
            setLayout()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(timeLabel)
        
        titleLabel.text = notice?.title
        timeLabel.text = notice?.time
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(8)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.left.right.equalToSuperview().inset(8)
        }
        
        selectionStyle = .none
        cellView.backgroundColor = .mainBlue.withAlphaComponent(0.1)
        cellView.layer.cornerRadius = 4
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .gray
    }
}
