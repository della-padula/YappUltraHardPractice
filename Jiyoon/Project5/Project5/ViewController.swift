//
//  ViewController.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    let apiManager = GithubManager()
    var urlString = ""
    
    var octLabel = UILabel()
    var sepLabel = UILabel()
    var augLabel = UILabel()
    
    var octCount = 0
    var sepCount = 0
    var augCount = 0
    
    
    static var resultList: [Date] = []
    let sundayImage: UIImageView = {
        $0.image = UIImage(named: "grass5")
        return $0
    }(UIImageView())
    
    let mondayImage: UIImageView = {
        $0.image = UIImage(named: "grass4")
        return $0
    }(UIImageView())
    
    let tuesdayImage: UIImageView = {
        $0.image = UIImage(named: "grass3")
        return $0
    }(UIImageView())
    
    let wednesdayImage: UIImageView = {
        $0.image = UIImage(named: "grass2")
        return $0
    }(UIImageView())
    
    let thursdayImage: UIImageView = {
        $0.image = UIImage(named: "grass1")
        return $0
    }(UIImageView())
    
    let fridayImage: UIImageView = {
        $0.image = UIImage(named: "grass5")
        return $0
    }(UIImageView())
    
    let saturdayImage: UIImageView = {
        $0.image = UIImage(named: "grass4")
        return $0
    }(UIImageView())
    
    let weekStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 3
        return $0
    }(UIStackView())
    
    let yearCollectionView: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        urlString = apiManager.fetchInfo()
        performRequest(url: urlString)
        setCollectionView()
        returnDict()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setLabels()
        reloadInputViews()
    }

    func setLabels() {
        augLabel.text = "8월의 커밋 수: \(augCount)회"
        augLabel.textColor = .black
        view.addSubview(augLabel)
        
        sepLabel.text = "9월의 커밋 수: \(sepCount)회"
        sepLabel.textColor = .black
        view.addSubview(sepLabel)
        
        octLabel.text = "10월의 커밋 수: \(octCount)회"
        octLabel.textColor = .black
        view.addSubview(octLabel)
        
        augLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
        }
        sepLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(200)
        }
        octLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(300)
        }
    }
    
    func setCollectionView() {
        [sundayImage, mondayImage, tuesdayImage, wednesdayImage, thursdayImage, fridayImage, saturdayImage].forEach {
            weekStackView.addArrangedSubview($0)
        }
        view.addSubview(weekStackView)
        weekStackView.snp.makeConstraints { make in
//            make.top.equalTo(400)
            make.centerX.equalToSuperview()
        }
        view.addSubview(yearCollectionView)
        yearCollectionView.addArrangedSubview(weekStackView)
        yearCollectionView.addArrangedSubview(weekStackView)

        yearCollectionView.snp.makeConstraints { make in
            make.top.equalTo(400)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - GithubManager
    var commitArray: [GitLog] = []
    var dateArray: [String] = []
    var dates: [Date] = []
    var dateDict: [String:Int] = [:]
    
    func fetchInfo() -> String {
        let urlString = "https://api.github.com/repos/glossyyoon/DailyCoding/commits?per_page=100"
        return urlString
    }
    
    func performRequest(url urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Any] {
                    for item in jsonData {
                        if let object = item as? [String: Any] {
                            if let committer = object["commit"] as? [String: Any] {
                                if let date = committer["author"] as? [String: Any] {
                                    if let finalDate = date["date"] as? String {
                                        self.dateArray.append(finalDate)
                                    }
                                }
                            }
                        }
                    }
                    self.stringToDate()
                    DateSingleton.shared.dates! = self.dateArray
                }
            }
            task.resume()
        }
        
    }
    
    func stringToDate() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        dateArray.forEach({
            let year = "\(dateFormatter.date(from: $0)!)".substring(from: 0, to: 3)
            let month = "\(dateFormatter.date(from: $0)!)".substring(from: 5, to: 6)
            let day = "\(dateFormatter.date(from: $0)!)".substring(from: 8, to: 9)
            let shortDay = year + month + day
            filterDates(date: shortDay)
            if shortDay.substring(from: 4, to: 5) == "08" {
                augCount += 1
            }
            if shortDay.substring(from: 4, to: 5) == "09" {
                sepCount += 1
            }
            if shortDay.substring(from: 4, to: 5) == "10" {
                octCount += 1
            }
        })
        countCommits()
        print(augCount, sepCount, octCount)
        
    }
    
    func filterDates(date: String) {
        for k in dateDict.keys {
            if date == k {
                dateDict[date]! += 1
                
            }
        }
        
        
    }
    
    func countCommits() {
        for i in 20210801...20210831 {
            if dateDict[String(i)] == nil {
                dateDict[String(i)] = 0
            }
        }
        for i in 20210901...20210930 {
            if dateDict[String(i)] == nil {
                dateDict[String(i)] = 0
            }
        }
        for i in 20211001...20211015 {
            if dateDict[String(i)] == nil {
                dateDict[String(i)] = 0
            }
        }

    }
    
    func returnDict() -> [String:Int]  {
        return dateDict
    }

}

