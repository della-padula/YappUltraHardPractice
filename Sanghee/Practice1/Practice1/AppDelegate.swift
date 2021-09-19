//
//  AppDelegate.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navC = UINavigationController()
        navC.viewControllers = [ViewController()]
        
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        
        return true
    }
}
