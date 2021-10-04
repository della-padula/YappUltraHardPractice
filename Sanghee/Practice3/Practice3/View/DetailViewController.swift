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
            print(mainUnit ?? "")
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
        view.addSubview(mainUnitView)
        
        mainUnitView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview().inset(16)
        }
    }
}
