//
//  ViewController.swift
//  Project3
//
//  Created by 박지윤 on 2021/10/03.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let transitionManager = CardTransitionManager()
    private let imageModel = Model()
    private var todayLabel = UILabel()
    private var dateLabel = UILabel()
    private var profileImageButton = UIButton()
    
    private let cardTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(CardCellController.self, forCellReuseIdentifier: CardCellController.cardIdentifier)
        return tableView
    }()
    private var header = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
    }
    
    func setUpUI() {
        todayLabel = {
            let label = UILabel()
            label.text = "Today"
            label.font = .boldSystemFont(ofSize: 30)
            label.textColor = .black
            return label
        }()
        dateLabel = {
            let label = UILabel()
            label.text = "SATURDAY 2 OCTOBER"
            label.font = .systemFont(ofSize: 13)
            label.textColor = .gray
            return label
        }()
        profileImageButton = {
            let button = UIButton()
            let image = UIImage(systemName: "person.crop.circle")?.withTintColor(.blue)
            button.setImage(image, for: .normal)
            return button
        }()
        header = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
            return view
        }()
    
        view.addSubview(cardTableView)
        view.addSubview(todayLabel)
        view.addSubview(dateLabel)
        view.addSubview(profileImageButton)
        
        cardTableView.dataSource = self
        cardTableView.delegate = self
        cardTableView.separatorStyle = .none
        cardTableView.backgroundColor = .clear
        
        cardTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(800)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.9)
        }
        todayLabel.snp.makeConstraints {
            $0.bottom.equalTo(cardTableView.snp.top).offset(-15)
            $0.leading.equalTo(cardTableView)
        }
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(todayLabel.snp.top).offset(-10)
            $0.leading.equalTo(todayLabel)
        }
        profileImageButton.snp.makeConstraints {
            $0.bottom.equalTo(cardTableView.snp.top).offset(-15)
            $0.trailing.equalTo(cardTableView)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCellController.cardIdentifier)! as UITableViewCell
        cell.backgroundView = UIImageView(image: imageModel.images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        detailView.modalPresentationStyle = .overFullScreen
        detailView.transitioningDelegate = self
        
        self.present(detailView, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPath = cardTableView.indexPathsForSelectedRows,
              let selectedCell = cardTableView.cellForRow(at: selectedIndexPath.first!) as? CardCellController,
              let selectedCellSuperView = selectedCell.superview else { return nil }
        transitionManager.originFrame = selectedCellSuperView.convert(selectedCell.frame, to: nil)
        return transitionManager
    }
    
}
