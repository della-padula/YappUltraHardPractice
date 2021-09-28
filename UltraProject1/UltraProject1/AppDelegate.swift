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
        KakaoSDKCommon.initSDK(appKey: "f625fe254b3e502498ae32a72c7d35ca")
        
        let isLoggedIn = KakaoAuthManager.shared.getIsLoggedIn()
        
        window = UIWindow()
        window?.rootViewController = isLoggedIn ? MainViewController() : LoginViewController()
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

