//
//  BookmarkController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/22.
//

import SnapKit
import UIKit

class BookmarkController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let bookmarkKey = "Bookmark"
    private let tableView = UITableView()

    private var bookmarkList: [Notice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureTableView()
        configureRefreshControl()
        
        getData()
    }
    
    private func getData() {
        
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        tableView.refreshControl?.tintColor = .mainBlue
    }
    
    @objc
    private func handleRefreshControl() {
        getData()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
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
        navigationController?.pushViewController(DetailController(bookmarkList[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as! NoticeTableViewCell
        cell.notice = bookmarkList[indexPath.row]
        return cell
    }
}
