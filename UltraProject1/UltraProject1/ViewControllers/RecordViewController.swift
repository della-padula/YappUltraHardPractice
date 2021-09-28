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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureTableView()
        getData()
    }
    
    private func getData() {
        scoreList = CoreDataManager.shared.getScores()
        tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "게임 기록"
        navigationController?.navigationBar.tintColor = .white
        
        let deleteBtn = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteRecords(_:)))
        deleteBtn.tintColor = .white
        
        navigationItem.rightBarButtonItem = deleteBtn
        
        let navigationBar = navigationController?.navigationBar
            
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = .mainGreen
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                
            navigationBar?.standardAppearance = navigationBarAppearance
            navigationBar?.compactAppearance = navigationBarAppearance
            navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        } else {
            navigationBar?.barTintColor = .mainGreen
            navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar?.tintColor = .white
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc
    private func deleteRecords(_ sender: UIButton) {
        CoreDataManager.shared.deleteAllScores()
        tableView.reloadData()
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifier, for: indexPath) as? ScoreTableViewCell else { return UITableViewCell() }
        cell.score = scoreList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let score: Score = scoreList[indexPath.row]
        let resultVC = ResultViewController()
        resultVC.data = score
        resultVC.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
