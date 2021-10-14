//
//  GitHubManager.swift
//  Practice5
//
//  Created by leeesangheee on 2021/10/15.
//

import Alamofire
import Foundation

class GitHubManager {
    static let shared = GitHubManager()
    
    let owner = "sanghee-dev"
    
    var commits: [Commit] = []
    
    func getCommitsFromRepoPage(repo: String = "sanghee-dev", page: Int = 1) {
        let urlString = "https://api.github.com/repos/\(owner)/\(repo)/commits?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let value = value as? [[String: Any]] {
                    for data in value {
                        if let commit = data["commit"] as? [String: Any], let author = commit["author"] as? [String: Any], let dateString = author["date"] as? String {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            guard let date = dateFormatter.date(from: dateString) else { return }
                            self.commits.append(Commit(repo: repo, date: date))
                        }
                    }
                    print(self.commits)
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
