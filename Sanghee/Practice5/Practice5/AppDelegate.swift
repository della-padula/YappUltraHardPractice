//
//  AppDelegate.swift
//  Practice5
//
//  Created by leeesangheee on 2021/10/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

