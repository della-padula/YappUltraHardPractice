//
//  AppDelegate.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let mainVC = MainViewController()
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return true
    }
}

