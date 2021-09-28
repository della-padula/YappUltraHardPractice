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

    private let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let resultScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    private let firstTryCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let secondTryCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let failCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private let againButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.00, green: 0.70, blue: 0.27, alpha: 1.00)
        button.setTitle("다시 하기", for: .normal)
        button.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.00, green: 0.70, blue: 0.27, alpha: 1.00)
        button.setTitle("홈으로", for: .normal)
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var data: Score? {
        didSet {
            guard let data = data else { return }
            resultScoreLabel.text = "총 \(data.total)회 성공"
            firstTryCountLabel.text = "1회 재시도: \(data.first)개"
            secondTryCountLabel.text = "2회 재시도: \(data.second)개"
            failCountLabel.text = "실패(오답): \(data.wrong)개"
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setLabelUI()
        setButtonUI()
    }
    
    private func setLabelUI(){
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
    
    private func setButtonUI(){
        view.addSubview(againButton)
        view.addSubview(homeButton)
        
        againButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(UIScreen.main.bounds.height * -0.25)
            $0.centerX.equalToSuperview()
        }
        homeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(UIScreen.main.bounds.height * -0.15)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func againButtonTapped() {
        print(CoreDataManager.shared.getScores())
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func homeButtonTapped() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
