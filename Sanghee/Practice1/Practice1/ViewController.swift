//
//  ViewController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import Alamofire
import Kanna
import SnapKit
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://cse.snu.ac.kr/department-notices?&keys=&page=\(page)") else { return }
        AF.request(url).responseString { response in
            guard let html = response.value else { return }
            do {
                let doc = try Kanna.HTML(html: html, encoding: .utf8)
                let docTexts = doc.css("td")
                for docText in docTexts{
                    guard let text = docText.text else { return }
                    let startIdx: String.Index = text.index(text.startIndex, offsetBy: 13)
                    let endIdx: String.Index = text.index(text.endIndex, offsetBy: -11)
                    let slicedText = text[startIdx...endIdx]
                    print(slicedText)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        
        cell.textLabel?.text = "공지사항"
        
        return cell
    }
    
}
