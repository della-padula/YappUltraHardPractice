//
//  AppDelegate.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let main = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: main)
        window?.makeKeyAndVisible()
        return true
    }

    
}

