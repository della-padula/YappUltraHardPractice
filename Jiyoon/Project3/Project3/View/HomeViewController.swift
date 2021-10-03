//
//  ViewController.swift
//  Project3
//
//  Created by 박지윤 on 2021/10/03.
//

import UIKit

class HomeViewController: UIViewController {
    
    let transitionManager = CardTransitionManager()
    let label = UILabel()
    
    var cardTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(CardCellController.self, forCellReuseIdentifier: CardCellController.cardIdentifier)
        return tableView
    }()
    
    var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
        
    }
    
    func setUpUI() {
        view.addSubview(cardTableView)
        view.addSubview(label)
        
        cardTableView.dataSource = self
        cardTableView.delegate = self
        cardTableView.separatorStyle = .none
        cardTableView.backgroundColor = .clear
        
        cardTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(800)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.9)
        }
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
    }


}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCellController.cardIdentifier)! as UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        present(detailView, animated: true, completion: nil)
    }
    
    
}
