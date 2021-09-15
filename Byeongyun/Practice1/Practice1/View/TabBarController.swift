//
//  TabBarController.swift
//  Practice1
//  탭 바 세팅
//  Created by ITlearning on 2021/09/16.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.backgroundColor = #colorLiteral(red: 0.9160357603, green: 0.9160357603, blue: 0.9160357603, alpha: 1)
        self.tabBarController?.delegate = self
        settingTabBar()
    }
    
    func settingTabBar() {
        let mainVC = MainViewController()
        
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        
        let plusVC = PlusViewController()
        
        plusVC.tabBarItem.selectedImage = UIImage(systemName: "plus.rectangle.fill")
        plusVC.tabBarItem.image = UIImage(systemName: "plus.rectangle")
        //plusVC.modalPresentationStyle = .automatic
        
        let userVC = UserViewController()
        userVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        userVC.tabBarItem.image = UIImage(systemName: "person")
        
        //present(plusVC, animated: true)
        viewControllers = [mainVC, plusVC, userVC]
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isModalView = viewController is PlusViewController
        if isModalView {
            let plVC = UINavigationController(rootViewController: PlusViewController())
            self.present(plVC, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
        
    }
}
