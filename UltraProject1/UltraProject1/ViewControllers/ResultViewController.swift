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
    //MARK: - 라벨 선언
    private let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "게임 결과"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let resultScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "총 10회 성공"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    private let firstTryCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1회 재시도: 7회"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let secondTryCountLabel: UILabel = {
        let label = UILabel()
        label.text = "2회 재시도: 3회"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let failCountLabel: UILabel = {
        let label = UILabel()
        label.text = "실패(오답): 5회"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    //MARK: - 버튼 선언
    private let againButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.00, green: 0.70, blue: 0.27, alpha: 1.00)
        button.setTitle("다시 하기", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setLabelUI()
        setButtonUI()
    }
    
    func setLabelUI(){
        view.addSubview(resultTitleLabel)
        view.addSubview(resultScoreLabel)
        view.addSubview(firstTryCountLabel)
        view.addSubview(secondTryCountLabel)
        view.addSubview(failCountLabel)
        
        resultTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.2)
            $0.centerX.equalToSuperview()
        }
        resultScoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.3)
            $0.centerX.equalToSuperview()
        }
        firstTryCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.5)
            $0.centerX.equalToSuperview()
        }
        secondTryCountLabel.snp.makeConstraints {
            $0.top.equalTo(firstTryCountLabel).offset(30)
            $0.centerX.equalToSuperview()
        }
        failCountLabel.snp.makeConstraints {
            $0.top.equalTo(secondTryCountLabel).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setButtonUI(){
        view.addSubview(againButton)
        
        againButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(UIScreen.main.bounds.height * -0.1)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    func buttonTapped() {
        print(1)
    }
}
