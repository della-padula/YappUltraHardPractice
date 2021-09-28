//
//  GameScore.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/28.
//

import Foundation

struct Score: Codable, Equatable {
    let total: Int16
    let first: Int16
    let second: Int16
    let wrong: Int16
}
