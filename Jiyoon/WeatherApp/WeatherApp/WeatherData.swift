//
//  WeatherData.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import Foundation
struct WeatherData: Codable {
    let main: Main
}
struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}
