//
//  GrassCell.swift
//  Practice5
//
//  Created by leeesangheee on 2021/10/15.
//

import SnapKit
import UIKit

class GrassCell: UICollectionViewCell {
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    static let identifier = "GrassCell"
    
    var count: Int? {
        didSet {
            print(count)
            changeBgColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCellView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addCellView() {
        addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func changeBgColor() {
        let alpha = CGFloat(count ?? 0 / 10)
        cellView.backgroundColor = .systemGreen.withAlphaComponent(alpha)
    }
}
