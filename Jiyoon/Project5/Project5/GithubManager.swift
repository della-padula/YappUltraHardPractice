//
//  GithubManager.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import Foundation

class GithubManager {
    static let shared = GithubManager()
    
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
        })
        countCommits()
//        print(dateDict)
    }
    
    func filterDates(date: String) {
        for k in dateDict.keys {
            if date == k {
                dateDict[date]! += 1
                return
            }
        }
        dateDict[date] = 1
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
//        print(dateDict)

    }
    
    func returnDict() -> [String:Int]  {
        return dateDict
    }
    
}
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        return String(self[startIndex ..< endIndex])
    }
}
