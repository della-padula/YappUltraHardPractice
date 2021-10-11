//
//  AppDelegate.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let navC = UINavigationController()
        navC.viewControllers = [FolderViewController()]
        
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        
        return true
    }
}
