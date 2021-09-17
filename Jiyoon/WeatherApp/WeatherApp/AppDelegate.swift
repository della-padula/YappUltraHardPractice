//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
         window.rootViewController = ViewController()
         window.makeKeyAndVisible()

         self.window = window

         return true
    }
}

