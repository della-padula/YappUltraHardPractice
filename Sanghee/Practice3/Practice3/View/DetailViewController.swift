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
            print(mainUnit)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
