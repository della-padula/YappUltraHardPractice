//
//  Folder.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import Foundation

struct Folder {
    let id: UUID
    let path: String
    var name: String
    var folders: [Folder]
    var pictures: [Picture]
}
