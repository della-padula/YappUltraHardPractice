//
//  ChannelInfoCollectionViewCell.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/24.
//

import UIKit
import SnapKit
class ChannelInfoCollectionViewCell: UICollectionViewCell {

    static let cellId = "ChannelCell"

    private let channelImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let channelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UILabel.colorSwitch
        return label
    }()

    private let subscribeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.tintColor = .systemGray

        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [channelNameLabel, subscribeCountLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1

        return stackView
    }()

    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [channelImageView, labelStackView])
        channelImageView.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureData(_ data: VideoContent) {
        channelImageView.image = UIImage(named: data.channelImage)
        channelNameLabel.text = data.channelName
        subscribeCountLabel.text = data.channelInfo

    }

    private func configureLayout() {
        contentView.addSubview(totalStackView)
        totalStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
