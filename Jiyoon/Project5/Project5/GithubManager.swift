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
            dates.append(dateFormatter.date(from: $0)!)
        })
        print(dates)
    }
    
    func filterDates() {
        
    }
    
}
