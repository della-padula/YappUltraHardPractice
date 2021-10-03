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
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "ABCD"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundView = UIImageView(image: UIImage(named: "cellBackground"))
        layer.cornerRadius = 8
        contentView.addSubview(descriptionLabel)
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

