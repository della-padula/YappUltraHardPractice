//
//  ViewController.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/02.
//

import UIKit
import SnapKit
class MainViewController: UIViewController {
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "MONDAY 4 OCTOBER"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    private let toDayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, toDayTextLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    private let mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 80, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 400)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let scrollView = UIScrollView()
    
    private var presenter: Presenter!
    
    init(with presenter: Presenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = presenter.backgroundColor
        configureUI()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = presenter
        //mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: presenter.cellId)
        presenter.registerCells(for: mainCollectionView)
        
    }
    
    private func configureUI() {
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        mainCollectionView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(mainCollectionView.snp.top).offset(10)
            $0.leading.equalTo(mainCollectionView.snp.leading).offset(30)
        }
        
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
}
