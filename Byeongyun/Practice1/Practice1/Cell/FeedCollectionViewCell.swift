//
//  FeedCollectionViewCell.swift
//  Practice1
//  컬렉션 뷰 셀
//  Created by ITlearning on 2021/09/20.
//

import UIKit
class FeedCollectionViewCell: UICollectionViewCell {
    // Cell ID
    static let cellId = "FeedCell"
    private let collectionImageView = UIImageView()
    // Property Observer
    var cellDataSetting: Feed! {
        didSet {
            collectionImageView.image = cellDataSetting.uploadImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setUpCellImageViewer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 컬렉션 뷰 이미지 뷰어 세팅
    func setUpCellImageViewer() {
        contentView.addSubview(collectionImageView)
        collectionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(self.snp.height)
        }
    }
}
