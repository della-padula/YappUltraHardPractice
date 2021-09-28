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
                return
            }
            self.saveLogin()
        }
    }
    
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.saveLogin()
        }
    }
    
    private func saveLogin() {
        defaults.set(true, forKey: kakaoLoginKey)
        changeRootVC()
    }
    
    func saveLogOut() {
        defaults.set(false, forKey: kakaoLoginKey)
        UserApi.shared.logout { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getIsLoggedIn() -> Bool {
        return defaults.bool(forKey: kakaoLoginKey)
    }
    
    private func changeRootVC() {
        let ad = UIApplication.shared.delegate as! AppDelegate
        let navC = UINavigationController(rootViewController: MainViewController())
        ad.window?.rootViewController = navC
    }
}
