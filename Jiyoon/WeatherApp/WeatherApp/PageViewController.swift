//
//  PageViewController.swift
//  WeatherApp
//
//  Created by 박지윤 on 2021/09/18.
//

import Foundation
import SnapKit
import UIKit

class PageViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate{
    private let timeList = WeatherCellModel.getTimes()
    
    var locationNameLabel = UILabel()
    var locationTempLabel = UILabel()
    let temperaturesView = UIStackView()
    var tempHighLabel = UILabel()
    var tempLowLabel = UILabel()
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
        view.addSubview(locationNameLabel)
        view.addSubview(locationTempLabel)
        view.addSubview(temperaturesView)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset.left = 5
        collectionView.backgroundColor = UIColor(red: 0.24, green: 0.70, blue: 1.00, alpha: 1.00)

        temperaturesView.addArrangedSubview(tempHighLabel)
        temperaturesView.addArrangedSubview(tempLowLabel)
        temperaturesView.alignment = .center
        
        locationNameLabel.font = UIFont.systemFont(ofSize: 30)
        locationTempLabel.font = UIFont.systemFont(ofSize: 80)
        tempHighLabel.font = UIFont.systemFont(ofSize: 15)
        tempLowLabel.font = UIFont.systemFont(ofSize: 15)
        
        locationNameLabel.textColor = .white
        locationTempLabel.textColor = .white
        tempHighLabel.textColor = .white
        tempLowLabel.textColor = .white
        
        backButton.setBackgroundImage(UIImage(systemName: "list.bullet")?.withTintColor(.black), for: .normal)
        backButton.addTarget(self, action: #selector(tappedBack) , for: .touchUpInside)
        view.addSubview(backButton)
        
        locationNameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            maker.centerX.equalToSuperview()
        }
        locationTempLabel.snp.makeConstraints { maker in
            maker.top.equalTo(locationNameLabel.snp.bottom).offset(3)
            maker.centerX.equalToSuperview()
        }
        temperaturesView.snp.makeConstraints { maker in
            maker.top.equalTo(locationTempLabel.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        tempHighLabel.snp.makeConstraints { maker in
            maker.top.equalTo(locationTempLabel.snp.bottom)
        }
        tempLowLabel.snp.makeConstraints { maker in
            maker.top.equalTo(locationTempLabel.snp.bottom)
        }
        backButton.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-50)
            maker.height.equalTo(30)
            maker.width.equalTo(30)
        }
        collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(temperaturesView.snp.bottom).offset(50)
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            maker.height.equalTo(150)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell)!
        cell.cellTimeLabel.text = timeList[indexPath.row]
        return cell
    }
    
    @objc
    func tappedBack(){
        dismiss(animated: true, completion: nil)
    }
}
