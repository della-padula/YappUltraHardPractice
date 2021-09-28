//
//  PrintFn.swift
//  UltraProject1
//
//  Created by leeesangheee on 2021/09/28.
//

import Foundation

public func print(_ object: Any) {
    #if DEBUG
    Swift.print("DEBUG: \(object)")
    #endif
}
