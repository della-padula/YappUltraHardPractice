//
//  MainViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    private let startButton = UIButton()
    private let recordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureStartButton()
        configureRecordButton()
    }
    
    private func configureStartButton() {
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(160)
            make.height.equalTo(60)
        }
        
        startButton.setTitle("게임 시작", for: .normal)
        startButton.backgroundColor = .systemGray2
        startButton.layer.cornerRadius = 16
        
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func configureRecordButton() {
        view.addSubview(recordButton)
        
        recordButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(startButton.snp.bottom).offset(12)
            make.height.equalTo(60)
        }
        
        recordButton.setTitle("게임 기록", for: .normal)
        recordButton.backgroundColor = .systemGray2
        recordButton.layer.cornerRadius = 16
        
        recordButton.addTarget(self, action: #selector(recordButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func startButtonTapped(_ sender: UIButton) {
    }
    
    @objc
    private func recordButtonTapped(_ sender: UIButton) {
    }
}
