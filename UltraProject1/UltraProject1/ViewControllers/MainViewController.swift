//
//  MainViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("게임 시작", for: .normal)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("게임 기록", for: .normal)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(recordButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureStartButton()
        configureRecordButton()
    }
    
    private func configureStartButton() {
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(160)
            $0.height.equalTo(60)
        }
    }
    
    private func configureRecordButton() {
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
