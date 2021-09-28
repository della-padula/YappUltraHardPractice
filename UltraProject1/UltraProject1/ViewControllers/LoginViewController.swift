//
//  LoginViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import UIKit

class LoginViewController: UIViewController {
    private let authManager = KakaoAuthManager.shared
    
    private var logoNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Number"
        label.font = UIFont.boldSystemFont(ofSize: 60)
        return label
    }()
    
    private var logoGameLabel: UILabel = {
        let label = UILabel()
        label.text = "Game"
        label.font = UIFont.boldSystemFont(ofSize: 60)
        return label
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오톡 로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .kakaoYellow
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLabels()
        configureLoginButton()
    }
    
    private func configureLabels() {
        view.addSubview(logoNumberLabel)
        view.addSubview(logoGameLabel)
        
        logoNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.left.equalToSuperview().inset(24)
        }
        logoGameLabel.snp.makeConstraints {
            $0.top.equalTo(logoNumberLabel.snp.bottom)
            $0.left.equalToSuperview().inset(24)
        }
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(160)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        authManager.loginWithKakao()
    }
}
