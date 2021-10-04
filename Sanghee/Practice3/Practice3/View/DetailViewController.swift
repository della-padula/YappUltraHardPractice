//
//  DetailViewController.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/02.
//

import SnapKit
import UIKit

class DetailViewController: UIViewController {
    var mainUnit: MainUnit? {
        didSet {
            setMainUnitView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    private func setMainUnitView() {
        let mainUnitView = MainUnitView()
        mainUnitView.mainUnit = mainUnit
        
        let deleteBtn: UIButton = {
            let button = UIButton(type: .close)
            return button
        }()
        
        view.addSubview(mainUnitView)
        mainUnitView.addSubview(deleteBtn)
        
        mainUnitView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(view.bounds.width)
        }
        deleteBtn.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(16)
        }
    }
}
