//
//  ViewController.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import UIKit

class ViewController: UIViewController {
    let apiManager = GithubManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let urlString = apiManager.fetchInfo()
        apiManager.performRequest(url: urlString)
        print(apiManager.commitArray)
    }


}

