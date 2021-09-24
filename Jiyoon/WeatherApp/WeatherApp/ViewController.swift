//
//  ViewController.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//
import CoreData
import SnapKit
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var container: NSPersistentContainer!
    private var tableView = UITableView()
    var locationsList: [String] = ["서울특별시", "대전시", "대구시", "부산시"]
    var locationsInEngList: [String] = ["Seoul", "Daejeon", "Daegu", "Busan"]
    var tempList: [Double] = []
    var tempHighList: [Double] = []
    var tempLowList: [Double] = []
    var iconsList = [UIImage(systemName: "moon.stars")?.withTintColor(.white),
                UIImage(systemName: "sun.max")?.withTintColor(.white),
                UIImage(systemName: "sparkles")?.withTintColor(.white),
                UIImage(systemName: "cloud.sleet")?.withTintColor(.white)]
    var scaledIconsList: [UIImage] = []
    let targetSize = CGSize(width: 50, height: 50)
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7c2ab3586163eeb83b5f5babed0f6050&units=metric"
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                if error != nil{
                    print("perform request Error")
                    return
                }
                let decoder = JSONDecoder()
                do{
                    let w = try decoder.decode(WeatherData.self, from: data!)
                    let temp = w.main.temp
                    let tempMax = w.main.tempMax
                    let tempMin = w.main.tempMin
                    let weather = WeatherInfo(tempInfo: temp, tempMaxInfo: tempMax, tempLowInfo: tempMin)
                    self.tempList.append(weather.tempInfo)
                    self.tempHighList.append(weather.tempMaxInfo)
                    self.tempLowList.append(weather.tempLowInfo)
                    print(self.tempList)
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
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
            self.tableView.reloadData()
        }
        for icon in iconsList {
            let scaledIcon = renderer.image {
                draw in icon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            }
            scaledIconsList.append(scaledIcon)
        }
    }
    //MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.locationLabel.text = locationsList[indexPath.row]
//        cell.tempLabel.text = "\(tempList[indexPath.row])°C"
        cell.iconImage.image = scaledIconsList[indexPath.row]
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.locationsList.remove(at: indexPath.row)
            self.tempList.remove(at: indexPath.row)
            self.iconsList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PageViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        vc.locationNameLabel.text = locationsList[indexPath.row]
        vc.locationTempLabel.text = "\(tempList[indexPath.row])°"
        vc.tempHighLabel.text = "최고:\(tempHighList[indexPath.row])°"
        vc.tempLowLabel.text = "최저:\(tempLowList[indexPath.row])°"
    }
}
