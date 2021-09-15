//
//  DetailController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import UIKit

class DetailController: UIViewController {
    
    private var notice: Notice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    init(_ notice: Notice) {
        super.init(nibName: nil, bundle: nil)
        self.notice = notice
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
