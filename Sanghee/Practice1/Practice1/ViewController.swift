//
//  ViewController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import SnapKit
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        
        cell.textLabel?.text = "공지사항"
        
        return cell
    }
    
}
