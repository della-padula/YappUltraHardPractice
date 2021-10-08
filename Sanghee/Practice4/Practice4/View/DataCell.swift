//
//  DataCell.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import SnapKit
import UIKit

class DataCell: UICollectionViewCell{
    static let identifier = "DataCell"
    
    private let folderCellView = FolderCellView()
    private let pictureCellView = PictureCellView()
    
    var folder: Folder? {
        didSet {
            setupFolderView()
        }
    }
    var picture: Picture? {
        didSet {
            setupPictureView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFolderView() {
        folderCellView.folder = folder
        addSubview(folderCellView)
        
        folderCellView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func setupPictureView() {
        pictureCellView.picture = picture
        addSubview(pictureCellView)
        
        pictureCellView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
