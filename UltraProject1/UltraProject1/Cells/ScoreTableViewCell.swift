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
    
    private let totalLabel = UILabel()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let wrongLabel = UILabel()
       
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
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(wrongLabel)
        
        if let score = score {
            totalLabel.text = "총 \(score.total)회 성공"
            firstLabel.text = "1회 재시도 : \(score.first)회"
            secondLabel.text = "2회 재시도 : \(score.second)회"
            wrongLabel.text = "실패(오답) : \(score.wrong)회"
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        wrongLabel.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        selectionStyle = .none
        
        totalLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        firstLabel.font = UIFont.systemFont(ofSize: 14)
        secondLabel.font = UIFont.systemFont(ofSize: 14)
        wrongLabel.font = UIFont.systemFont(ofSize: 14)
        wrongLabel.textColor = .gray
    }
}
