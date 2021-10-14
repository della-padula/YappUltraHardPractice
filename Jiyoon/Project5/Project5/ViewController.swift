//
//  ViewController.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import UIKit

class ViewController: UIViewController {
    let apiManager = GithubManager()
    var urlString = ""
    static var resultList: [Date] = []
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        urlString = apiManager.fetchInfo()
        apiManager.performRequest(url: urlString)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apiManager.stringToDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print(GithubManager.shared.dates)
    }



}

