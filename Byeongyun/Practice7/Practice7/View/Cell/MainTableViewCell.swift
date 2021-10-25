//
//  MainTableViewCell.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    static let cellId = "MainTableCell"

    private let videoMainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let channelImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let videoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = UILabel.colorSwitch
        return label
    }()

    private let profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.systemGray

        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoNameLabel, profileLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()

    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [channelImageView, textStackView])
        channelImageView.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        textStackView.snp.makeConstraints {
            $0.centerY.equalTo(channelImageView.snp.centerY)
        }
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI(model: VideoContent) {
        videoMainImageView.image = UIImage(named: model.videoImage)
        channelImageView.image = UIImage(named: model.channelImage)
        videoNameLabel.text = model.videoMainLabel
        profileLabel.text = model.profileLabel

    }

    private func configureLayout() {

        contentView.addSubview(videoMainImageView)
        videoMainImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            let width = contentView.frame.width
            let height = contentView.frame.height
            $0.width.equalTo(width)
            $0.height.equalTo(width-(height*2.5))
            $0.bottom.equalTo(contentView.snp.bottom).offset(-55)
        }

        contentView.addSubview(totalStackView)
        totalStackView.snp.makeConstraints {
            $0.top.equalTo(videoMainImageView.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
