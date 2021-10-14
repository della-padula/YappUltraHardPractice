//
//  DateSingleton.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/15.
//

import Foundation
class DateSingleton {
    static let shared = DateSingleton()
    
    var dates: [String]? = []
    
    private init() { }
}
