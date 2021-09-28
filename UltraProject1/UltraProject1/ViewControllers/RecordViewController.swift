//
//  RecordViewController.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/27.
//

import SnapKit
import UIKit

class RecordViewController: UIViewController {
    private let tableView = UITableView()
    private var scoreList: [Score] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        getData()
    }
    
    private func getData() {
        scoreList = CoreDataManager.shared.getScores()
        //MARK: - 테스트 데이터
        scoreList.append(contentsOf: [Score(total: 10, first: 1, second: 2, wrong: 3),
                                      Score(total: 10, first: 1, second: 2, wrong: 3),
                                      Score(total: 10, first: 1, second: 2, wrong: 3),
                                      Score(total: 10, first: 1, second: 2, wrong: 3)])
        
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecordCell")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
        return cell
    }
}
