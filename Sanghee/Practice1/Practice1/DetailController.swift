//
//  DetailController.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import Alamofire
import Kanna
import SnapKit
import UIKit
import WebKit

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let labelView = UIView()
    private let webView = WKWebView()
    private let modalView = UIView()
    
    private var notice: Notice?
    private var fileUrlList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLabelView()
        
        DispatchQueue.main.async {
            self.configureWebView()
            self.configureModalView()
            self.getData()
        }
        
    }
    
    init(_ notice: Notice) {
        super.init(nibName: nil, bundle: nil)
        self.notice = notice
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getData() {
        guard let url = URL(string: notice?.url ?? "") else { return }
        
        AF.request(url).responseString { response in
            guard let html = response.value else { return }
            do {
                let doc = try Kanna.HTML(html: html, encoding: .utf8)
                let docTexts = doc.css("p")
                let htmlString = "<p style=\"font-size: 42;\">" + docTexts.compactMap({ $0.text }).reduce("") { $0 + $1 } + "</p>"
                self.webView.loadHTMLString(htmlString, baseURL: nil)
                
                let fileUrlTexts = doc.css("span")
                for fileUrlText in fileUrlTexts {
                    if let fileUrl = fileUrlText.css("a").first?["href"] {
                        self.fileUrlList.append(fileUrl)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func configureLabelView() {
        view.addSubview(labelView)
        labelView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().offset(8)
        }
        
        let titleLabel = UILabel()
        let timeLabel = UILabel()
        
        labelView.addSubview(titleLabel)
        labelView.addSubview(timeLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.text = notice?.title
        timeLabel.text = notice?.time
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = .gray
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureModalView() {
        let modalTableView = UITableView()
        let separatorView = UIView()
        
        modalTableView.delegate = self
        modalTableView.dataSource = self
        modalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FileUrlCell")
                
        view.addSubview(modalView)
        modalView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        modalView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
        
        modalView.addSubview(modalTableView)
        modalTableView.snp.makeConstraints { make in
            make.top.equalTo(modalView.snp.top).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        
        separatorView.backgroundColor = .systemGroupedBackground
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // fileUrlList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileUrlCell", for: indexPath)
        
        cell.textLabel?.text = "첨부파일"
        
        return cell
    }
    
}
