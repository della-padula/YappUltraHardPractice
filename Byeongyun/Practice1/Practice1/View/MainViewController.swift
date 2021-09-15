//
//  ViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    let tableViewCell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
    let image = UIImageView(image: UIImage(systemName: "person.fill"))
    
    // MARK: - 탭 바 버튼 선언
    let homeButton = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    let plusButton = UITabBarItem(title: "", image: UIImage(systemName: "plus.rectangle"), selectedImage: UIImage(systemName: "plus.rectangle.fill"))
    let userfeedButton = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        tabBarSetting()
        tableViewCellSetting()
        settingUI()
        
    }
    
    // MARK: - tabBar 세팅
    func tabBarSetting() {
        tabBar.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        tabBar.items = [homeButton, plusButton, userfeedButton]
    }
    
    func tableViewCellSetting() {
        tableViewCell.contentView.addSubview(image)
    }
    
    // MARK: - UI 세팅
    func settingUI() {
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-50)
            $0.bottom.equalTo(tabBar.snp.top)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }
}

