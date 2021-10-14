//
//  GithubModel.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/14.
//

import Foundation

struct GithubJSONModel: Codable {
    let commit: Commit
}
struct Commit: Codable {
    let committer: Committer
    let message: String
}
struct Committer: Codable {
    let name: String
    let date: Date
}
