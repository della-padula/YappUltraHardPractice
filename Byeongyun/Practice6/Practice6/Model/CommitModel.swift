//
//  CommitModel.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/14.
//

import Foundation

struct CommitModel: Codable {
    var items: [Item]
    let incomplete_results: Bool
}

struct Item: Codable {
    let commit: Commit
    //let url: String
    //let sha: String
}

struct Commit: Codable {
    let committer: Commiter
    //let message: String
}

struct Commiter: Codable {
    let date: String
}

