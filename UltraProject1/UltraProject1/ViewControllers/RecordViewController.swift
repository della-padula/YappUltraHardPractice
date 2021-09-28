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
        let testScore = Score(total: 10, first: 9, second: 8, wrong: 7)
        scoreList.append(contentsOf: [testScore, testScore, testScore, testScore])
        
        tableView.reloadData()
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
        resultVC.modalPresentationStyle = .fullScreen
        present(resultVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
