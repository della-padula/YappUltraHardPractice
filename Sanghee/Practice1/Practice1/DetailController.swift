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

class DetailController: UIViewController {
    
    private let labelView = UIView()
    private let webView = WKWebView()
    
    private var notice: Notice?
    private var urlList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLabelView()
        
        DispatchQueue.main.async {
            self.configureWebView()
            
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
                let docTexts = doc.css("p") // "p"
                let htmlString = "<p style=\"font-size: 42;\">" + docTexts.compactMap({ $0.text }).reduce("") { $0 + $1 } + "</p>"
                self.webView.loadHTMLString(htmlString, baseURL: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.right.bottom.equalToSuperview()
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
    
}
