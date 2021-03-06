//
//  AppDelegate.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let presenter = Presenter()
        window?.rootViewController = MainViewController(with: presenter)
        window?.makeKeyAndVisible()
        return true
    }



}

