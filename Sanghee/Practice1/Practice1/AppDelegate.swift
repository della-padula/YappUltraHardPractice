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
        let viewNavC = UINavigationController()
        let bookmarkNavC = UINavigationController()
        let viewC = ViewController()
        let bookmarkC = BookmarkController()
        
        tabC.viewControllers = [viewNavC, bookmarkNavC]
        viewNavC.viewControllers = [viewC]
        bookmarkNavC.viewControllers = [bookmarkC]
        
        viewC.tabBarItem = UITabBarItem(title: "공지", image: UIImage(systemName: "megaphone"), selectedImage: UIImage(systemName: "megaphone.fill"))
        bookmarkC.tabBarItem = UITabBarItem(title: "북마크", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))

        tabC.tabBar.tintColor = Constants.Color.blue
        
        window?.rootViewController = tabC
        window?.makeKeyAndVisible()
        
        return true
    }
}
