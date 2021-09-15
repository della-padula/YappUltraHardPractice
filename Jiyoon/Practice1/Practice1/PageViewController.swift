//
//  PageControl.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/15.
//

import Foundation
import SnapKit

class PageViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate{
    var time = ["12", "1", "2", "3", "4", "5", "6"]
    
    var locationName = UILabel()
    var locationTemp = UILabel()
    let temperatures = UIStackView()
    var tempHigh = UILabel()
    var tempLow = UILabel()
    var backButton = UIButton()
    
//    var pageControll: UIPageControl{
//        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(.white)
        view.addSubview(locationName)
        view.addSubview(locationTemp)
        view.addSubview(temperatures)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset.left = 5

        temperatures.addArrangedSubview(tempHigh)
        temperatures.addArrangedSubview(tempLow)
        temperatures.alignment = .center
        
        locationName.font = UIFont.systemFont(ofSize: 30)
        locationTemp.font = UIFont.systemFont(ofSize: 80)
        tempHigh.font = UIFont.systemFont(ofSize: 15)
        tempLow.font = UIFont.systemFont(ofSize: 15)
        
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
        cell.backgroundColor = .white
        cell.snp.makeConstraints { maker in
            maker.height.equalTo(CGSize(width: 0, height: 150))
            maker.width.equalTo(CGSize(width: 60, height: 0))
        }
        return cell
    }
    
    @objc
    func tappedBack(){
        dismiss(animated: true, completion: nil)
    }

    
}
