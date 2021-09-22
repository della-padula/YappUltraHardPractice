//
//  BookmarkController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/22.
//

import UIKit

class BookmarkController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationItem.title = "북마크"
        navigationBar?.barTintColor = Constants.Color.blue
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.tintColor = .white
        navigationBar?.barStyle = .black
    }
}
