//
//  ViewController.swift
//  Practice1
//  메인 뷰 컨트롤러
//  Created by ITlearning on 2021/09/16.
//

// 아직 해결해야할 이 앱의 문제점
// 1. 게시글이 2줄이 넘어가면 ...으로 안보인다.
// 2. 유저 뷰 초기 실행시, 약간의 버벅임(?) 이 보인다. 또한, 기기의 layout을 계산한 것이 아닌, 단순히 숫자로 계산하여 sticky header를 구현하여 보완이 필요하다.

import SnapKit
import UIKit
import CoreData

// 기본 세팅 값이 들어가있는 전역변수 어레이
// 테스트를 위해 추가했습니다.

class MainViewController: UIViewController {
    
    // 뷰가 보이기 전 실행
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        readFeedContacts()
        tableView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //let endIndex = IndexPath(row: 0, section: 0)
        //tableView.scrollToRow(at: endIndex, at: .top, animated: true)
    }
    
    // MARK: - Main 타이틀
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "CloneStagram"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    private var feedContacts: [FeedArray] = []
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewCellSetting()
        settingUI()
        readFeedContacts()
    }
    
    private func readFeedContacts() {
        feedContacts = CoreDataWorker.shared.read()
        tableView.reloadData()
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
        return feedContacts.count
    }
    // 테이블 뷰 크기
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     
    // 커스텀 셀 정의
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellId, for: indexPath) as! FeedTableViewCell
        // 클릭시 색 없게 설정
        cell.selectionStyle = .none
        cell.cellDataSetting = feedContacts[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "수정") { (_, _, success: @escaping (Bool) -> Void) in
            let plusViewController = PlusViewController()
            plusViewController.feedContact = self.feedContacts[indexPath.row]
            plusViewController.modalPresentationStyle = .fullScreen
            self.present(plusViewController, animated: true, completion: nil)
            success(true)
        }
        edit.backgroundColor = .systemBlue
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_,_, success: @escaping (Bool) -> Void) in
            let selectedFeedContact = self.feedContacts[indexPath.row]
            CoreDataWorker.shared.delete(selectedFeedContact)
            self.feedContacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}
