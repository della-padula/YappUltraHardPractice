//
//  AppDelegate.swift
//  UltraProject1
//
//  Created by denny on 2021/09/27.
//

import CoreData
import KakaoSDKAuth
import KakaoSDKCommon
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let infoDic: [String: Any] = Bundle.main.infoDictionary {
            if let info = infoDic["CFBundleURLTypes"] as? [Any],
            let dic = info[0] as? NSDictionary,
            let key = dic.value(forKey: "CFBundleURLSchemes") as? [String] {
                let str = key[0]
                let startIdx: String.Index = str.index(str.startIndex, offsetBy: 5)
                KakaoSDKCommon.initSDK(appKey: String(str[startIdx...]))
            }
        }
                
        let isLoggedIn = KakaoAuthManager.shared.getIsLoggedIn()
        let loginVC = LoginViewController()
        let mainVC = MainViewController()
               
        let navC = UINavigationController(rootViewController: isLoggedIn ? mainVC : loginVC)

        window = UIWindow()
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}

