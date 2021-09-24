//
//  TabBarController.swift
//  Practice1
//  탭 바 세팅
//  Created by ITlearning on 2021/09/16.
//

import UIKit
class TabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = #colorLiteral(red: 0.9160357603, green: 0.9160357603, blue: 0.9160357603, alpha: 1)
        settingTabBar()
    }
    
    // MARK: - TabBar 세팅
    func settingTabBar() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.rectangle"), for: UIControl.State.normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(plusButtonAction(sender:)), for: UIControl.Event.touchUpInside)
        let mainVC = MainViewController()
        self.view.addSubview(button)
        button.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            $0.width.equalTo(54)
            $0.height.equalTo(54)
        }
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        let plusVC = PlusViewController()
        let userVC = UserViewController()
        userVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        userVC.tabBarItem.image = UIImage(systemName: "person")
        viewControllers = [mainVC, plusVC, userVC]
    }
    
    // MARK: - 추가 버튼 클릭 시 작업 메서드
    @objc
    func plusButtonAction(sender: UIButton) {
        let plusVC = PlusViewController()
        plusVC.modalPresentationStyle = .fullScreen
        self.present(plusVC, animated: true, completion: nil)
    }
}


