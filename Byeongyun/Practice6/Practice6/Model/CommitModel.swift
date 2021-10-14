//
//  CommitModel.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/14.
//

import Foundation

struct CommitModel: Codable {
    let total_count: Int
    var items: [Item]
    let incomplete_results: Bool
}

struct Item: Codable {
    let commit: Commit
}

struct Commit: Codable {
    let committer: Commiter
}

struct Commiter: Codable {
    let date: String
}

