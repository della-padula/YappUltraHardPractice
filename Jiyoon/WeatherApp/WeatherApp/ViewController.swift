//
//  ViewController.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var table = UITableView()
    var location: [String] = ["서울특별시", "대전시", "대구시", "부산시"]
    var location_eng: [String] = ["Seoul", "Daejeon", "Daegu", "Busan"]
    var temp: [String] = []
    var tempHigh: [String] = []
    var tempLow: [String] = []
    var icons = [UIImage(systemName: "moon.stars")?.withTintColor(.white),
                UIImage(systemName: "sun.max")?.withTintColor(.white),
                UIImage(systemName: "sparkles")?.withTintColor(.white),
                UIImage(systemName: "cloud.sleet")?.withTintColor(.white)]
    var scaledIcons: [UIImage] = []
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
                    self.temp.append("\(weather.tempInfo)")
                    self.tempHigh.append("\(weather.tempMaxInfo)")
                    self.tempLow.append("\(weather.tempLowInfo)")
                }
                catch{
                    print("Error in JSON parsing")
                }
            }
            task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(WeatherCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .black
        self.table.separatorStyle = .none
        view.addSubview(table)
        
        table.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        for locate in location_eng{
            fetchWeather(cityName: locate)
        }
        for icon in icons{
            let scaledIcon = renderer.image {
                draw in icon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            }
            scaledIcons.append(scaledIcon)
        }
    }
    //MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.locationLabel.text = self.location[indexPath.row]
        cell.tempLabel.text = "\(self.temp[indexPath.row])°C"
        cell.iconImage.image = self.scaledIcons[indexPath.row]
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.location.remove(at: indexPath.row)
            self.temp.remove(at: indexPath.row)
            self.icons.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PageViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        vc.locationName.text = location[indexPath.row]
        vc.locationTemp.text = "\(temp[indexPath.row])°"
        vc.tempHigh.text = "최고:\(tempHigh[indexPath.row])°"
        vc.tempLow.text = "최저:\(tempLow[indexPath.row])°"
    }
}
