//
//  WeatherManager.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/16.
//

import Foundation

protocol weatherManagerDelegate {
    func update(_ weatherManager: WeatherManager, weather: WeatherInfo)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7c2ab3586163eeb83b5f5babed0f6050&units=metric"
    
//    let delegate = weatherManagerDelegate
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession.shared
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("perform request Error")
                    return
                }
                let decoder = JSONDecoder()
                do{
                    let w = try decoder.decode(WeatherData.self, from: data!)
                    let temp = w.main.temp
                    let tempMax = w.main.temp_max
                    let tempMin = w.main.temp_min
                    let weather = WeatherInfo(tempInfo: temp, tempMaxInfo: tempMax, tempLowInfo: tempMin)
                    print(weather)
//                    self.delegate.update(self, weather: weather)
                }
                catch{
                    print("Error in JSON parsing")
                }
            }
            task.resume()
        }
    }
}
