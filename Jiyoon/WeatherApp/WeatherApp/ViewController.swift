//
//  ViewController.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//
import CoreData
import SnapKit
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var mainTableView = UITableView()
    private var locationsInEngList: [String] = ["Seoul", "Daejeon", "Daegu", "Busan"]
    private let targetSize: CGSize = CGSize(width: 50, height: 50)
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7c2ab3586163eeb83b5f5babed0f6050&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString, cityName: cityName)
    }
    
    func performRequest(with urlString: String, cityName: String) {
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("perform request Error")
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let w = try decoder.decode(WeatherData.self, from: data!)
                    let newWeather = Weather(context: WeatherCoreDataManager.context)
                    newWeather.temp = w.main.temp
                    newWeather.tempMax = w.main.tempMax
                    newWeather.tempMin = w.main.tempMin
                    newWeather.location = cityName
                    WeatherCoreDataManager.weatherArray.append(newWeather)
                    WeatherCoreDataManager.saveWeathers()
                }
                catch{
                    print("Error in JSON parsing", "\(error)")
                }
            }
            
            task.resume()
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        mainTableView.backgroundColor = .black
        mainTableView.separatorStyle = .none
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        func fetchFromCityName(completionHandler: @escaping () -> Void){
            for locate in self.locationsInEngList{
                self.fetchWeather(cityName: locate)
            }
        }
        fetchFromCityName {
            self.mainTableView.reloadData()
        }
        
        
    }
    //MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        WeatherCell.indexPath = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
//            WeatherCoreDataManager.deleteWeathers(WeatherCoreDataManager)
//            self.locationsList.remove(at: indexPath.row)
//            self.iconsList.remove(at: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PageViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        vc.locationNameLabel.text = "\(WeatherCoreDataManager.weatherArray[indexPath.row].location!)"
        vc.locationTempLabel.text = "\(WeatherCoreDataManager.weatherArray[indexPath.row].temp)"
        vc.tempHighLabel.text = "최고: \(WeatherCoreDataManager.weatherArray[indexPath.row].tempMax)"
        vc.tempLowLabel.text = "최저: \(WeatherCoreDataManager.weatherArray[indexPath.row].tempMin)"
    }
}
