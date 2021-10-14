//
//  AppDelegate.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
//        let navVC = UINavigationController()
//        let rootVC = ViewController()
//
//        navVC.viewControllers = [rootVC]
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

