//
//  ViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "CloneStagram"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    //let tabBar = TabBarController()
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    let feed: [Feed] = [
        Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", uploadImage: UIImage(named: "swift")!),
        Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", uploadImage: UIImage(named: "swift")!),
        Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", uploadImage: UIImage(named: "swift")!),
        Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", uploadImage: UIImage(named: "swift")!),
        Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", uploadImage: UIImage(named: "swift")!),
        Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", uploadImage: UIImage(named: "swift")!)
                        ]
    
    // MARK: - 탭 바 버튼 선언
    
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        //tabBarSetting()
        tableViewCellSetting()
        settingUI()
        
    }
    
    // MARK: - Table View Cell 세팅
    func tableViewCellSetting() {
        
        // TableView에 TableViewCell을 새로 생성할 때 사용하는 코드
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 0
    }
    
    // MARK: - UI 세팅
    func settingUI() {
        //view.addSubview(tabBar)
        /*
        tabBar.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        */
        view.addSubview(mainTitle)
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    // 테이블 뷰 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    // 커스텀 셀 정의
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellId, for: indexPath) as! FeedTableViewCell
        
        cell.userUploadImage.image = feed[indexPath.row].uploadImage
        //cell.userImage.sizeThatFits(CGSize(width: 400, height: 50))
        //cell.userImage.sizeToFit()
        cell.userName.text = feed[indexPath.row].userName
        cell.userText.text = feed[indexPath.row].text
        cell.userImage.image = feed[indexPath.row].userImage
        cell.textUserName.text = feed[indexPath.row].userName
        return cell
    }
    
}
