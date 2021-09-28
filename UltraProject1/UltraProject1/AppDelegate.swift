//
//  AppDelegate.swift
//  UltraProject1
//
//  Created by denny on 2021/09/27.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = GameViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

