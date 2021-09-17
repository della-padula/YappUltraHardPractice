//
//  PageControl.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/15.
//

import Foundation
import SnapKit

class PageViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate{
    var time = ["1시", "2시", "3시", "4시", "5시", "6시", "7시", "8시", "9시", "10시", "11시"]
    
    var locationName = UILabel()
    var locationTemp = UILabel()
    let temperatures = UIStackView()
    var tempHigh = UILabel()
    var tempLow = UILabel()
    var backButton = UIButton()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: 60, height: 150)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        view.addSubview(locationName)
        view.addSubview(locationTemp)
        view.addSubview(temperatures)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset.left = 5
        collectionView.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)

        temperatures.addArrangedSubview(tempHigh)
        temperatures.addArrangedSubview(tempLow)
        temperatures.alignment = .center
        
        locationName.font = UIFont.systemFont(ofSize: 30)
        locationTemp.font = UIFont.systemFont(ofSize: 80)
        tempHigh.font = UIFont.systemFont(ofSize: 15)
        tempLow.font = UIFont.systemFont(ofSize: 15)
        
        locationName.textColor = .white
        locationTemp.textColor = .white
        tempHigh.textColor = .white
        tempLow.textColor = .white
        
        backButton.setBackgroundImage(UIImage(systemName: "list.bullet")?.withTintColor(.black), for: .normal)
        backButton.addTarget(self, action: #selector(tappedBack) , for: .touchUpInside)
        view.addSubview(backButton)
        
        locationName.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        locationTemp.snp.makeConstraints { maker in
            maker.top.equalTo(locationName.snp.bottom).offset(3)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        temperatures.snp.makeConstraints { maker in
            maker.top.equalTo(locationTemp.snp.bottom)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        tempHigh.snp.makeConstraints { maker in
            maker.top.equalTo(locationTemp.snp.bottom)
        }
        tempLow.snp.makeConstraints { maker in
            maker.top.equalTo(locationTemp.snp.bottom)
        }
        backButton.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-50)
            maker.height.equalTo(CGSize(width: 30, height: 30))
            maker.width.equalTo(CGSize(width: 30, height: 30))
        }
        collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(temperatures.snp.bottom).offset(50)
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            maker.height.equalTo(CGSize(width: 0, height: 150))
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return time.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.cellTimeLabel.text = time[indexPath.row]
        cell.cellWeatherIcon.image = UIImage(systemName: "sun.max.fill")?.withTintColor(.yellow)
        cell.cellTempLabel.text = "19"
        cell.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)
        return cell
    }
    
    @objc
    func tappedBack(){
        dismiss(animated: true, completion: nil)
    }

    
}
