//
//  WeatherManager.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/16.
//

import Foundation

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7c2ab3586163eeb83b5f5babed0f6050&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("perform request Error")
                    return
                }
                if let safeData = data{
                    let parsing = parsonJSON(safeData)
                }
            }
            task.resume()
        }
    }
    func parsonJSON(_ weatherData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather_id = decodedData.id
            let weather_location = decodedData.location
            let weather_temp = decodedData.temp
            
            let weather = WeatherData(id: weather_id, location: weather_location, temp: weather_temp)
            return weather
        }
        catch{
            print("Error while do parseJSON")
            return nil
        }
    }
}
