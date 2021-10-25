//
//  VideoCollectionViewCell.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/21.
//

import UIKit
import SnapKit
class VideoInfoCollectionViewCell: UICollectionViewCell {

    static let cellId = "InfoCell"

    private let videoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 10
        label.textColor = UILabel.colorSwitch
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let videoInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray

        return label
    }()

    private let thumbsUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.imageView?.tintColor = UILabel.colorSwitch
        button.addTarget(self, action: #selector(thumbsUpAction), for: .touchUpInside)
        return button
    }()

    private let thumbsDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.imageView?.tintColor = UILabel.colorSwitch
        button.addTarget(self, action: #selector(thumbsDownAction), for: .touchUpInside)
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.imageView?.tintColor = UILabel.colorSwitch
        button.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        return button
    }()

    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.imageView?.tintColor = UILabel.colorSwitch
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoTitleLabel, videoInfoLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2

        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thumbsUpButton, thumbsDownButton, shareButton, saveButton])

        stackView.spacing = 1
        let width = contentView.snp.width
        thumbsUpButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        thumbsDownButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        shareButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        saveButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        return stackView
    }()


    @objc
    func thumbsUpAction() {
        print("준비중")
    }

    @objc
    func thumbsDownAction() {
        print("준비중")
    }

    @objc
    func shareAction() {
        print("준비중")
    }

    @objc
    func saveAction() {
        print("준비중")
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configureData(_ data: VideoContent) {
        videoTitleLabel.text = data.videoMainLabel
        videoInfoLabel.text = data.profileLabel
    }

    private func configureLayout() {
        contentView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        contentView.addSubview(titleStackView)
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.bottom.equalTo(buttonStackView.snp.top)
        }
        videoInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing)
            $0.height.equalTo(20)
        }
    }
}
