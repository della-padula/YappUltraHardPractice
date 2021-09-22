//
//  Notice.swift
//  Practice1
//
//  Created by leeesangheee on 2021/09/16.
//

import Foundation

struct Notice {
    let title: String
    let time: String
    let url: String
    var isBookmarked: Bool {
        let bookmarks = UserDefaults.standard.array(forKey: "Bookmark") as? [String] ?? []
        return bookmarks.contains(url)
    }
}
