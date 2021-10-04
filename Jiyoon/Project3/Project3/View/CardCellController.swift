//
//  CardViewController.swift
//  Project3
//
//  Created by 박지윤 on 2021/10/03.
//

import SnapKit
import UIKit

class CardCellController: UITableViewCell {
    static var cardIdentifier = "cardCell"
    var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 8
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

