//
//  LoginViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오톡 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .kakaoYellow
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLoginButton()
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
    }
}
