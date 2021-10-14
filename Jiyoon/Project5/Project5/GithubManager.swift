//
//  GithubManager.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import Foundation

class GithubManager {
    var commitArray: [GitLog] = []
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
                do {
                    let commitLog = try decoder.decode(GithubJSONModel.self, from: data[0]!)
                    let date = commitLog.commit.committer.date
                    let message = commitLog.commit.message
                    let name = commitLog.commit.committer.name
                    let newCommitLog = GitLog(date: date, message: message, name: name)
                    self.commitArray.append(newCommitLog)
                }
                catch {
                    print(error.localizedDescription)
                }
                
            }
            task.resume()
        }
    }
}
