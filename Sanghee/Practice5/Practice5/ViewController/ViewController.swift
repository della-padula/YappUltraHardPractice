//
//  ViewController.swift
//  Practice5
//
//  Created by leeesangheee on 2021/10/13.
//

import SnapKit
import UIKit

final class ViewController: UIViewController {
    // MARK: - header
    private let headerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Contributions"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    // MARK: - textField
    private let textFieldView = UIView()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "깃허브 아이디를 입력하세요"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.cornerRadius = 8
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 1))
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 1))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private let textFieldBtn: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray4
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        return button
    }()
    
    // MARK: - grassView
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
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        return view
    }()
    
    // MARK: - graphView
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
    
    // MARK: -
    private let manager = GitHubManager.shared
    
    private var owner: String = "sanghee-dev"
    private var commits: [Commit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        manager.getCommitsFromRepoPage()
        
        setupHeaderView()
        setupTextField()
        setupGrassView()
        setupGraphView()
        
        addButtonAction()
    }
}

private extension ViewController {
    func addButtonAction() {
        textFieldBtn.addTarget(self, action: #selector(textFieldBtnTapped), for: .touchUpInside)
    }
    
    @objc func textFieldBtnTapped() {
        guard let text = textField.text else { return }
        print(text)
        owner = text
    }
}

extension ViewController: UITextFieldDelegate {
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
            $0.top.left.right.equalToSuperview()
        }
    }
    
    func setupTextField() {
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        textFieldView.addSubview(textFieldBtn)

        textFieldView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        textFieldBtn.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
    
    func setupGrassView() {
        view.addSubview(grassView)
        grassView.addSubview(grassOwnerLabel)
        grassView.addSubview(grassContributionsLabel)
        grassView.addSubview(grassCollectionView)
        grassView.addSubview(dividerView)
        
        grassView.snp.makeConstraints {
            $0.top.equalTo(textFieldView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        
        grassOwnerLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        grassContributionsLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview()
        }
        
        grassCollectionView.snp.makeConstraints {
            $0.top.equalTo(grassOwnerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
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
            $0.top.left.equalToSuperview()
        }
        
        graphContributionsLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview()
        }
        
        graphCartView.snp.makeConstraints {
            $0.top.equalTo(graphOwnerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
