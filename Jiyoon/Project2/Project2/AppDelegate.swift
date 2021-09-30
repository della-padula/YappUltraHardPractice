//
//  AppDelegate.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TimerViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

