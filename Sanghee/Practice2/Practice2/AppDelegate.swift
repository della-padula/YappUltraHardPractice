//
//  AppDelegate.swift
//  Practice2
//
//  Created by leeesangheee on 2021/09/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = MapViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

