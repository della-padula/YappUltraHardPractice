//
//  GithubManager.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import Foundation

class GithubManager {
    static var commitArray: [GitLog] = []
    static var dateArray: [String] = []
    func fetchInfo() -> String {
        let urlString = "https://api.github.com/repos/glossyyoon/DailyCoding/commits?per_page=100&page=3"
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
                let decoder = JSONDecoder()
                
                if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Any] {
                    for item in jsonData {
                        if let object = item as? [String: Any] {
                            
                            let commit = object["commit"]
                            if let committer = object["commit"] as? [String: Any] {
                                if let date = committer["author"] as? [String: Any] {
                                    if let finalDate = date["date"] as? String {
                                        print(finalDate)
                                    }
                                }
                            }
//                            let date = object["commit"] as? String ?? "N/A"
//                            print("date=\(date)")
                        }
//                        do {
//                            let commitLog = try decoder.decode(GithubJSONModel.self, from: item as Data)
//                            let date = commitLog.commit.committer.date
////                            print(date)
//                            GithubManager.dateArray.append(commitLog.commit.committer.date)
//                            let message = commitLog.commit.message
//                            let name = commitLog.commit.committer.name
//                            let newCommitLog = GitLog(date: date, message: message, name: name)
//                            GithubManager.commitArray.append(newCommitLog)
//                        }
//                        catch {
//                            print(error.localizedDescription)
//                        }
                    }
                }
                print("**",GithubManager.dateArray)
                print("!!",GithubManager.commitArray)
            }
            task.resume()
        }
    }
}
