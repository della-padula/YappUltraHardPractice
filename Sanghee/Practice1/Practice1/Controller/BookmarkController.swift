//
//  BookmarkController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/22.
//

import SnapKit
import UIKit

class BookmarkController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()

    private var noticeList: [Notice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureTableView()
        
        getData()
    }
    
    private func getData() {
        
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "북마크"
        let navigationBar = navigationController?.navigationBar
        
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = .mainBlue
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            navigationBar?.standardAppearance = navigationBarAppearance
            navigationBar?.compactAppearance = navigationBarAppearance
            navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        } else {
            navigationBar?.barTintColor = .mainBlue
            navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar?.tintColor = .white
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailController(noticeList[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as! NoticeTableViewCell
        cell.notice = noticeList[indexPath.row]
        return cell
    }
}
