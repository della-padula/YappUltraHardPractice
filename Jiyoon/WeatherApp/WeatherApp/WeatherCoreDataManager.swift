//
//  WeatherCoreData.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/25.
//
import CoreData
import UIKit

class WeatherCoreDataManager {
    static var weatherArray: [Weather] = []
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = appDelegate.persistentContainer.viewContext //AppDelegate 안에 있는 persistentContainer를 꺼내옴
    let newWeather = Weather(context: context)
    static func saveWeathers(){
        do {
            try WeatherCoreDataManager.context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }
    
    func loadWeathers() {
        let request: NSFetchRequest<Weather> = Weather.fetchRequest()
        do{
            WeatherCoreDataManager.weatherArray = try WeatherCoreDataManager.context.fetch(request)
        } catch {
            print("Error fetching data, \(error)")
        }
    }
    
    func deleteWeathers(indexPath: IndexPath) {
        WeatherCoreDataManager.context.delete(WeatherCoreDataManager.weatherArray[indexPath.row])
        WeatherCoreDataManager.weatherArray.remove(at: indexPath.row)
        WeatherCoreDataManager.saveWeathers()
    }
}
