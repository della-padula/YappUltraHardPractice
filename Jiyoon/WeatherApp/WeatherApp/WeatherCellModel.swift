//
//  WeatherCellModel.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/23.
//

import Foundation
import UIKit

struct WeatherCellModel {
    static func getTimes() -> [String] {
        let times = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시"]
        return times
    }
}
