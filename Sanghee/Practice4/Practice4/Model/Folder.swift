//
//  Folder.swift
//  Practice4
//
//  Created by leeesangheee on 2021/10/08.
//

import Foundation

struct Folder {
    let uuid: String = UUID().uuidString
    let path: String
    let name: String
    let pictures: [Picture]
}
