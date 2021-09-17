//
//  ViewController.swift
//  Practice1
//
//  Created by denny on 2021/09/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var table = UITableView()
    var weatherManager = WeatherManager()
    
    var location: [String] = ["서울특별시", "대전시", "대구시", "부산시"]
    var location_eng: [String] = ["Seoul", "Daejeon", "Daegu", "Busan"]
    var temp: [String] = ["28", "29", "30", "31"]
    var tempHigh: [String] = ["28", "29", "30", "31"]
    var tempLow: [String] = ["28", "29", "30", "31"]
    var icons = [UIImage(systemName: "moon.stars")?.withTintColor(.white),
                UIImage(systemName: "sun.max")?.withTintColor(.white),
                UIImage(systemName: "sparkles")?.withTintColor(.white),
                UIImage(systemName: "cloud.sleet")?.withTintColor(.white)]
    var scaledIcons: [UIImage] = []
    let targetSize = CGSize(width: 50, height: 50)
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
    

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
        for city in location_eng{
            let weather = weatherManager.fetchWeather(cityName: city)
            
        }
        
        for icon in icons{
            let scaledIcon = renderer.image {
                draw in icon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            }
            scaledIcons.append(scaledIcon)
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.locationLabel.text = location[indexPath.row]
        cell.tempLabel.text = "\(temp[indexPath.row])°C"
        cell.iconImage.image = scaledIcons[indexPath.row]
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
//        let vc = Views()
//        vc.modalPresentationStyle = .fullScreen
    }
    

}
extension ViewController: weatherManagerDelegate{
    func update(_ weatherManager: WeatherManager, weather: WeatherInfo) {
        temp.append("\(weather.tempInfo)")
        
    }
}
