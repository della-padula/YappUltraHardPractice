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
    private var notice: Notice?
    private var fileUrlList: [FileUrl] = []
    private let modalHeight: CGFloat = 160
    
    private let labelView = UIView()
    private let webView = WKWebView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureBarBtns()
        configureLabelView()
        configureWebView()
        getData()
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
                
                var trimmedTextArr = docTexts.compactMap({ $0.text })
                if trimmedTextArr[0].trimmingCharacters(in: .whitespaces).isEmpty {
                    trimmedTextArr.removeFirst()
                }
                
                let htmlString = "<p style=\"font-size: 42;\">" + trimmedTextArr.map({ $0 + "<br>" }).reduce("") { $0 + $1 }  + "</p>"
                self.webView.loadHTMLString(htmlString, baseURL: nil)

                let fileUrlTexts = doc.css("td")
                for fileUrlText in fileUrlTexts {
                    let fileName = fileUrlText.css("a").first?.text
                    if let fileUrl = fileUrlText.css("a").first?["href"] {
                        self.fileUrlList.append(FileUrl(title: fileName ?? "첨부 파일", url: fileUrl))
                    }
                }
                
                if !self.fileUrlList.isEmpty {
                    self.configureModalView()
                    self.addBottomSpaceToWebView()
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    private func bookmarkTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let bookmarks = defaults.array(forKey: "Bookmark") as? [String] ?? []
        var newBookmarks = bookmarks
        
        if let notice = notice {
            if bookmarks.contains(notice.url) {
                newBookmarks = newBookmarks.filter({ $0 != notice.url })
            } else {
                newBookmarks.append(notice.url)
            }
            defaults.set(newBookmarks, forKey: "Bookmark")
            defaults.synchronize()
        }
        configureBarBtns()
    }
    
    @objc
    private func linkTapped(_ sender: UIButton) {
        guard let link = notice?.url else { return }
        showActivityVC([link])
    }
    
    private func configureView() {
        view.backgroundColor = .white
        self.navigationItem.title = "상세보기"
    }
    
    private func configureBarBtns() {
        let bookmarkBtn = UIBarButtonItem(image: UIImage(systemName: notice?.isBookmarked ?? false ? "bookmark.fill" : "bookmark"), style: .plain, target: self, action: #selector(bookmarkTapped(_:)))
        let linkBtn = UIBarButtonItem(image: UIImage(systemName: "link"), style: .plain, target: self, action: #selector(linkTapped(_:)))
        self.navigationItem.rightBarButtonItems = [bookmarkBtn, linkBtn]
    }

    private func configureLabelView() {
        let titleLabel = UILabel()
        let timeLabel = UILabel()
        
        view.addSubview(labelView)
        labelView.addSubview(titleLabel)
        labelView.addSubview(timeLabel)
        
        labelView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
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
            make.top.equalTo(labelView.snp.bottom)
            make.left.right.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func addBottomSpaceToWebView() {
        webView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(modalHeight * (-1))
        }
    }
    
    private func configureModalView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FileUrlCell.self, forCellReuseIdentifier: FileUrlCell.identifier)
        
        let separatorView = UIView()
        let tableContainerView = UIView()
        let maxY = view.frame.origin.y + view.frame.size.height
        let rect = CGRect(x: 0, y: maxY, width: view.bounds.width, height: modalHeight)
        let myView = UIView(frame: rect)

        view.addSubview(myView)
        myView.addSubview(separatorView)
        myView.addSubview(tableContainerView)
        tableContainerView.addSubview(tableView)
        
        separatorView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
        tableContainerView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            myView.frame = CGRect(x: 0, y: maxY - self.modalHeight, width: self.view.bounds.width, height: self.modalHeight)
        }
        
        separatorView.backgroundColor = .systemGroupedBackground
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileUrlList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileUrlCell.identifier, for: indexPath) as! FileUrlCell
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = false
        
        cell.index = indexPath.row
        cell.fileUrl = fileUrlList[indexPath.row]
        
        return cell
    }
    
    private func showActivityVC(_ items: [Any]) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension DetailController: ButtonDelegate {
    func showAlert(index: Int) {
        let alert = UIAlertController(title: "파일 다운로드", message: "파일을 다운로드하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .default) { _ in
            let link = self.fileUrlList[index].url
            self.showActivityVC([link])
        }
        let noAction = UIAlertAction(title: "아니요", style: .destructive)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
}
