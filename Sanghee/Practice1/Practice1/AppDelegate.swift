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
        
        let tabC = UITabBarController()
        let vcNavC = UINavigationController()
        let bookmarkNavC = UINavigationController()
        let vc = ViewController()
        let bookmarkVC = BookmarkViewController()
        
        tabC.viewControllers = [vcNavC, bookmarkNavC]
        vcNavC.viewControllers = [vc]
        bookmarkNavC.viewControllers = [bookmarkVC]
        
        vc.tabBarItem = UITabBarItem(title: "공지", image: UIImage(systemName: "megaphone"), selectedImage: UIImage(systemName: "megaphone.fill"))
        bookmarkVC.tabBarItem = UITabBarItem(title: "북마크", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))

        tabC.tabBar.backgroundColor = .systemGroupedBackground
        tabC.tabBar.tintColor = .mainBlue
        
        window?.rootViewController = tabC
        window?.makeKeyAndVisible()
        
        return true
    }
}
