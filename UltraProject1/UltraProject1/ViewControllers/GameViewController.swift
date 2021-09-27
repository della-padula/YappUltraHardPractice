//
//  GameViewController.swift
//  UltraProject1
//
//  Created by ITlearning on 2021/09/27.
//

import UIKit
import SnapKit
class GameViewController: UIViewController {

    private var numbers = [
        1,2,3,4,
        5,6,7,8,
        9,10,11,12,
        13,14,15,16
    ]
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "남은 시간 "
        label.textAlignment = .center
        return label
    }()
    
    let selectNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.text = "15"
        label.textAlignment = .center
        return label
    }()
    
    let numberCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        settingCollection()
        settingUI()
    }
    
    func settingCollection() {
        numberCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.cellId)
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
    }
    
    func settingUI() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.centerX.equalToSuperview()
        }
        view.addSubview(selectNumberLabel)
        selectNumberLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(numberCollectionView)
        numberCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectNumberLabel.snp.bottom).offset(60)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(30)
        }
    }
}


extension GameViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.cellId, for: indexPath) as? GameCollectionViewCell else { return UICollectionViewCell() }
        cell.numberLabel.text = "\(numbers[indexPath.row])"
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        layout.sectionInset = UIEdgeInsets(top: 1, left: 3, bottom: 3, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.invalidateLayout()
        return CGSize(width: (self.view.frame.width/5)-5, height: (self.view.frame.width/5)-5)
        
    }
    
    // 셀 선택시 인덱스 받아오는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
