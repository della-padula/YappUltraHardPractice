//
//  ScoreTableViewCell.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/28.
//

import SnapKit
import UIKit

class ScoreTableViewCell: UITableViewCell {
    static let identifier = "ScoreCell"
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let scoresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
       
    var score: Score? {
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
        contentView.addSubview(totalLabel)
        contentView.addSubview(scoresLabel)
        
        if let score = score {
            totalLabel.text = "총 \(score.total)회 성공"
            scoresLabel.text = "1회 재시도 : \(score.first)회, 2회 재시도 : \(score.second)회, 실패(오답) : \(score.wrong)회"
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(12)
        }
        
        scoresLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(12)
        }
        
        selectionStyle = .none
    }
}
