//
//  MainCollectionViewCell.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/03.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    static let cellId = "MainCell"
    
    private var initalFrame: CGRect?
    private var initalCornerRadius: CGFloat?
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.65)
        return imageView
    }()

    private let cellSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    private let cellMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    
    private lazy var cellMainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cellSubLabel, cellMainLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        return stackView
    }()
    
    private let appImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "kart_icon"))
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let appMainLabel: UILabel = {
        let label = UILabel()
        label.text = "KartRider Rush+"
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let appSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Real-time Kart Racing Thrill"
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var subStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appMainLabel, appSubLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        return stackView
    }()
    
    private let openButton: UIButton = {
        let button = UIButton()
        button.setTitle("OPEN", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 13
        return button
    }()
    
    private let cellSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    var cellMainImage: String? {
        didSet {
            guard let mainImage = cellMainImage else { return }
            cellImageView.image = UIImage(named: mainImage)
        }
    }
    
    var cellSubString: String? {
        didSet {
            guard let subString = cellSubString else { return }
            cellSubLabel.text = subString
        }
    }
    
    var cellMainString: String? {
        didSet {
            guard let mainString = cellMainString else { return }
            cellMainLabel.text = mainString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellUI() {
        
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(-60)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(600)
        }
        
        contentView.addSubview(cellMainStackView)
        cellMainStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
        }
        
        contentView.addSubview(cellSubView)
        cellSubView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).offset(-70)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(500)
        }
        
        cellSubView.addSubview(appImageView)
        appImageView.snp.makeConstraints {
            $0.top.equalTo(cellSubView.snp.top).offset(13)
            $0.leading.equalTo(cellSubView.snp.leading).offset(10)
            $0.height.equalTo(45)
            $0.width.equalTo(45)
        }
        
        cellSubView.addSubview(openButton)
        openButton.snp.makeConstraints {
            $0.top.equalTo(cellSubView.snp.top).offset(25)
            $0.trailing.equalTo(cellSubView.snp.trailing).offset(-20)
            $0.width.equalTo(60)
            $0.height.equalTo(25)
        }
        
        cellSubView.addSubview(subStackView)
        subStackView.snp.makeConstraints {
            $0.top.equalTo(cellSubView.snp.top).offset(13)
            $0.leading.equalTo(appImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(openButton.snp.leading).offset(-30)
        }
        
        contentView.bringSubviewToFront(cellSubView)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = contentView.layer.cornerRadius
        
    }
    
    func expand(in collectionView: UICollectionView) {
        initalFrame = self.frame
        initalCornerRadius = self.contentView.layer.cornerRadius
        self.contentView.layer.cornerRadius = 0
        self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width * 0.4, height: collectionView.frame.height * 0.4)
        layoutIfNeeded()
    }
    
    func collapse() {
        self.contentView.layer.cornerRadius = initalCornerRadius ?? self.contentView.layer.cornerRadius
        self.frame = initalFrame ?? self.frame
        initalFrame = nil
        initalCornerRadius = nil
        layoutIfNeeded()
    }
    
}
