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
        button.setTitle("다시 하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("홈으로", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var data: Score? {
        didSet {
            guard let data = data else { return }
            resultScoreLabel.text = "총 \(data.total)회 성공"
            firstTryCountLabel.text = "1회 재시도 : \(data.first)개"
            secondTryCountLabel.text = "2회 재시도 : \(data.second)개"
            failCountLabel.text = "실패(오답) : \(data.wrong)개"
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setLabelUI()
        if !isRecordVC() {
            setButtonUI()
        }
    }
    
    init(afterGame: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        if (afterGame) {
            setButtonUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func isRecordVC() -> Bool {
        let viewControllers = navigationController?.viewControllers ?? []
        if let index = viewControllers.firstIndex(of: self) {
            let previousVC = viewControllers[index - 1]
            return type(of: previousVC) == RecordViewController.self
        }
        return false
    }
    
    private func setLabelUI(){
        [resultTitleLabel, resultScoreLabel, firstTryCountLabel, secondTryCountLabel, failCountLabel].forEach { view.addSubview($0) }
        
        resultTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
        }
        
        resultScoreLabel.snp.makeConstraints {
            $0.top.equalTo(resultTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        firstTryCountLabel.snp.makeConstraints {
            $0.top.equalTo(resultScoreLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        secondTryCountLabel.snp.makeConstraints {
            $0.top.equalTo(firstTryCountLabel.snp.bottom)
            $0.right.equalTo(firstTryCountLabel.snp.right)
        }
        
        failCountLabel.snp.makeConstraints {
            $0.top.equalTo(secondTryCountLabel.snp.bottom)
            $0.right.equalTo(firstTryCountLabel.snp.right)
        }
    }
    
    private func setButtonUI(){
        view.addSubview(againButton)
        view.addSubview(homeButton)
        
        againButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(160)
            $0.height.equalTo(60)
        }
        
        homeButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalTo(againButton.snp.bottom).offset(12)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    private func againButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        TimerManager.createTimer()
    }
    
    @objc
    private func homeButtonTapped() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
            }
    }
}
