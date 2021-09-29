//
//  MainViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    
    private var logoStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Number"
        label.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width/5)
        return label
    }()
    
    private var logoFinishLabel: UILabel = {
        let label = UILabel()
        label.text = "Game"
        label.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width/5)
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("게임 시작", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("게임 기록", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(recordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLabels()
        setStartButton()
        setRecordButton()
    }
    
    private func setLabels() {
        view.addSubview(logoStartLabel)
        view.addSubview(logoFinishLabel)
        
        logoStartLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.left.equalToSuperview().inset(24)
        }
        logoFinishLabel.snp.makeConstraints {
            $0.top.equalTo(logoStartLabel.snp.bottom)
            $0.left.equalToSuperview().inset(24)
        }
    }
    
    private func setStartButton() {
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(160)
            $0.height.equalTo(60)
        }
    }
    
    private func setRecordButton() {
        view.addSubview(recordButton)
        
        recordButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalTo(startButton.snp.bottom).offset(12)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    private func startButtonTapped(_ sender: UIButton) {
        let gameVC = GameViewController()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc
    private func recordButtonTapped(_ sender: UIButton) {
        let recordVC = RecordViewController()
        self.navigationController?.pushViewController(recordVC, animated: true)
    }
}
