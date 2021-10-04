//
//  DetailViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class DetailViewController: UIViewController {
    private let mainUnitView = MainUnitView()
    private let paragraphLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    let deleteBtn: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    var mainUnit: MainUnit? {
        didSet {
            setmainUnitView()
            setParagraphLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @objc
    private func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: DetailView {
    func setmainUnitView() {
        mainUnitView.mainUnit = mainUnit
        
        view.addSubview(mainUnitView)
        view.addSubview(deleteBtn)
        
        mainUnitView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(view.bounds.width)
        }
        deleteBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    func setParagraphLabel() {
        paragraphLabel.text = mainUnit?.paragraph
        
        view.addSubview(paragraphLabel)
        
        paragraphLabel.snp.makeConstraints {
            $0.top.equalTo(mainUnitView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
}
