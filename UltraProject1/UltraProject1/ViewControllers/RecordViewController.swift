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
    private var deleteBtn: UIBarButtonItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(animated, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
        setNavigationBarButton()
        setTableView()
        getData()
    }
    
    private func getData() {
        scoreList = CoreDataManager.shared.getScores()
        tableView.reloadData()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "게임 기록"
        navigationController?.navigationBar.tintColor = .white
        
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
    
    private func setNavigationBarButton() {
        deleteBtn = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(showDeleteAlert(_:)))
        deleteBtn?.tintColor = .white
        deleteBtn?.isEnabled = CoreDataManager.shared.getScores().count > 0
        
        navigationItem.rightBarButtonItem = deleteBtn
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc
    private func showDeleteAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "기록 삭제", message: "전체 기록을 삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .destructive) { _ in
            CoreDataManager.shared.deleteAllScores()
            self.deleteBtn?.isEnabled = false
            self.getData()
            self.tableView.reloadData()
        }
        let noAction = UIAlertAction(title: "아니요", style: .default)
                
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
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
