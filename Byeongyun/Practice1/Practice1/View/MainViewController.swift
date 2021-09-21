//
//  ViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import SnapKit
import UIKit

// 기본 세팅 값이 들어가있는 전역변수 어레이
var feedArray : [Feed] = [
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "two")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "three")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "four")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date()),
    Feed(userImage: UIImage(named: "user")!, userName: "IBY", text: "Hello", like: 88, uploadImage: UIImage(named: "one")!, time: Date())

]


class MainViewController: UIViewController {
    
    // 뷰가 보이기 전 실행
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let endIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: endIndex, at: .top, animated: true)
    }
    
    // MARK: - Main 타이틀
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "CloneStagram"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableViewCellSetting()
        settingUI()
        
    }
    
    // MARK: - Table View Cell 세팅
    func tableViewCellSetting() {
        
        // TableView에 TableViewCell을 새로 생성할 때 사용하는 코드
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        // 테이블 뷰 라인 중앙으로 옮기기
        tableView.separatorInset.left = 0
    }
    
    // MARK: - UI 세팅
    func settingUI() {
        
        // 메인 타이틀
        view.addSubview(mainTitle)
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            
        }
        
        // 테이블 뷰
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }
}


// MARK: - TableView 익스텐션
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 테이블 뷰 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension
        
    }
    
    // 커스텀 셀 정의
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellId, for: indexPath) as! FeedTableViewCell
        cell.selectionStyle = .none
        cell.userUploadImage.image = feedArray[indexPath.row].uploadImage
        cell.userName.text = feedArray[indexPath.row].userName
        cell.userText.text = feedArray[indexPath.row].text
        cell.userImage.image = feedArray[indexPath.row].userImage
        cell.textUserName.text = feedArray[indexPath.row].userName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH:mm"
        let currentString = formatter.string(from: feedArray[indexPath.row].time)
        
        cell.date.text = currentString
        cell.likeStatus.text = "\(feedArray[indexPath.row].like) 명이 좋아합니다"
        
        return cell
    }
    
}
