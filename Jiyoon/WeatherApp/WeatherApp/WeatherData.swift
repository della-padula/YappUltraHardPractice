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
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }

}
