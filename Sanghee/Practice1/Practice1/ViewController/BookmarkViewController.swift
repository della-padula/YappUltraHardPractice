//
//  BookmarkViewController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/22.
//

import SnapKit
import UIKit

class BookmarkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let manager = CoreDataManager.shared
    private let bookmarkKey = "Bookmark"
    private let tableView = UITableView()

    private var bookmarkList: [Notice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureNavigationBarBtn()
        configureTableView()
        configureRefreshControl()
        
        getData()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        configureNavigationBarBtn()
        tableView.reloadData()
    }
    
    private func getData() {
        bookmarkList = CoreDataManager.shared.getBookmarks()
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        tableView.refreshControl?.tintColor = .mainBlue
    }
    
    @objc
    private func handleRefreshControl() {
        getData()
        configureNavigationBarBtn()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    @objc
    private func showDeleteAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "북마크 삭제", message: "북마크를 다 삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
            self.manager.deleteAllBookmarks()
            self.configureNavigationBarBtn()
            self.getData()
            self.tableView.reloadData()
        }
        let noAction = UIAlertAction(title: "아니요", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func configureNavigationBarBtn() {
        let bookmarks = manager.getBookmarks()
        
        let deleteBtn = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(showDeleteAlert(_:)))
        deleteBtn.isEnabled = bookmarks.count != 0
        
        deleteBtn.tintColor = .white
        navigationItem.rightBarButtonItem = deleteBtn
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
        navigationController?.pushViewController(DetailViewController(bookmarkList[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else { return UITableViewCell() }
        cell.notice = bookmarkList[indexPath.row]
        return cell
    }
}
