//
//  LoginViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLoginButton()
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(160)
            make.height.equalTo(60)
        }
        
        loginButton.setTitle("카카오톡 로그인", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .kakaoYellow
        loginButton.layer.cornerRadius = 16
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
    }
}
