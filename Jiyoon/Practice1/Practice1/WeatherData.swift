//
//  WeatherData.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/16.
//

import Foundation
struct WeatherData: Decodable {
    var id: Int
    var location: String
    var temp: Float
}
