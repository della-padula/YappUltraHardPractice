//
//  ViewController.swift
//  Practice5
//
//  Created by leeesangheee on 2021/10/13.
//

import SnapKit
import UIKit

final class ViewController: UIViewController {
    private let headerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Contributions"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        return view
    }()
    
    private let grassView = UIView()
    
    private let grassOwnerLabel: UILabel = {
        let label = UILabel()
        label.text = "sanghee-dev"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let grassContributionsLabel: UILabel = {
        let label = UILabel()
        label.text = "1000 contributions"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let grassCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = .systemGreen
        return collectionView
    }()
    
    private let graphView = UIView()
    
    private let graphOwnerLabel: UILabel = {
        let label = UILabel()
        label.text = "sanghee-dev"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let graphContributionsLabel: UILabel = {
        let label = UILabel()
        label.text = "1000 contributions"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let graphCartView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let manager = GitHubManager.shared
    
    private var commits: [Commit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        manager.getCommitsFromRepoPage()
        
        setupHeaderView()
        setupGrassView()
        setupGraphView()
    }
}

private extension ViewController {
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
    
    func setupGrassView() {
        view.addSubview(grassView)
        grassView.addSubview(grassOwnerLabel)
        grassView.addSubview(grassContributionsLabel)
        grassView.addSubview(grassCollectionView)
        grassView.addSubview(dividerView)
        
        grassView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        
        grassOwnerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        grassContributionsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        grassCollectionView.snp.makeConstraints {
            $0.top.equalTo(grassOwnerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setupGraphView() {
        view.addSubview(graphView)
        graphView.addSubview(graphOwnerLabel)
        graphView.addSubview(graphContributionsLabel)
        graphView.addSubview(graphCartView)
        
        graphView.snp.makeConstraints {
            $0.top.equalTo(grassView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        
        graphOwnerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        graphContributionsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        graphCartView.snp.makeConstraints {
            $0.top.equalTo(graphOwnerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
