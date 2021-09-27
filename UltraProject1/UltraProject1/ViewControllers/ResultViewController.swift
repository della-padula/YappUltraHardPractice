//
//  ResultViewController.swift
//  UltraProject1
//
//  Created by 박지윤 on 2021/09/27.
//

import Foundation
import SnapKit
import UIKit

class ResultViewController: UIViewController {
    let resultTitleLable = UILabel()
    let resultScoreLabel = UILabel()
    let try1CountLabel = UILabel()
    let try2CountLabel = UILabel()
    let failCountLabel = UILabel()
    let againButton = UIButton()
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(resultTitleLable)
        view.addSubview(resultScoreLabel)
        view.addSubview(try1CountLabel)
        view.addSubview(try2CountLabel)
        view.addSubview(failCountLabel)
        view.addSubview(againButton)
        
        resultTitleLable.text = "게임 결과"
        resultTitleLable.font = UIFont.systemFont(ofSize: 30)
        
        resultScoreLabel.text = "총 10회 성공"
        resultScoreLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        try1CountLabel.text = "1회 재시도: 7회"
        try1CountLabel.font = UIFont.systemFont(ofSize: 20)
        try2CountLabel.text = "2회 재시도: 3회"
        try2CountLabel.font = UIFont.systemFont(ofSize: 20)
        failCountLabel.text = "실패(오답): 5회"
        failCountLabel.font = UIFont.systemFont(ofSize: 20)
        
        againButton.backgroundColor = UIColor(red: 1.00, green: 0.70, blue: 0.27, alpha: 1.00)
        againButton.setTitle("다시 하기", for: .normal)
        
        resultTitleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        resultScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(resultTitleLable).offset(100)
            make.centerX.equalToSuperview()
        }
        try1CountLabel.snp.makeConstraints { make in
            make.top.equalTo(resultScoreLabel).offset(200)
            make.centerX.equalToSuperview()
        }
        try2CountLabel.snp.makeConstraints { make in
            make.top.equalTo(try1CountLabel).offset(50)
            make.centerX.equalToSuperview()
        }
        failCountLabel.snp.makeConstraints { make in
            make.top.equalTo(try2CountLabel).offset(50)
            make.centerX.equalToSuperview()
        }
        againButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalToSuperview()
        }
    }
}
