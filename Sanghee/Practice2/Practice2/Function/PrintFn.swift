//
//  PrintFn.swift
//  Practice2
//
//  Created by leeesangheee on 2021/09/30.
//

import Foundation

public func print(_ object: Any) {
    #if DEBUG
    Swift.print("DEBUG: \(object)")
    #endif
}
