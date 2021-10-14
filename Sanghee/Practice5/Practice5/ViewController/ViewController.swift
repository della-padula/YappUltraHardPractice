//
//  ViewController.swift
//  Practice5
//
//  Created by leeesangheee on 2021/10/13.
//

import UIKit

final class ViewController: UIViewController {
    private let manager = GitHubManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        manager.getCommitsFromRepoPage()
    }
}
