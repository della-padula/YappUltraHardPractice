//
//  KakaoAuthManager.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/28.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthManager {
    static var shared: KakaoAuthManager = KakaoAuthManager()
    private let defaults = UserDefaults.standard
    private let kakaoLoginKey = "KakaoLogin"
    
    func loginWithKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
    
    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.saveLogin()
            print("로그인 결과: \(self.getIsLoggedIn())")
        }
    }
    
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.saveLogin()
            print("로그인 결과: \(self.getIsLoggedIn())")
        }
    }
    
    private func saveLogin() {
        defaults.set(true, forKey: kakaoLoginKey)
        print("로그인 결과: \(self.getIsLoggedIn())")
    }
    
    func saveLogOut() {
        UserApi.shared.logout { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        defaults.set(false, forKey: kakaoLoginKey)
        print("로그인 결과: \(self.getIsLoggedIn())")
    }
    
    func getIsLoggedIn() -> Bool {
        return defaults.bool(forKey: kakaoLoginKey)
    }
}
