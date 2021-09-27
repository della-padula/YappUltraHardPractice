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
    
    private var tappedNumbers: [Int] = []
    
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
    
    let wrongCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "틀린 횟수 : 0"
        label.textAlignment = .center
        
        return label
    }()
    
    let numberCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var randomNumberShared: Int?
    var wrongNumber: Int = 0
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingCollection()
        settingUI()
        settingLabel()
    }
    
    func settingLabel() {
        guard let randomNumber = numbers.randomElement() else { return }
        randomNumberShared = randomNumber
        selectNumberLabel.text = "\(randomNumberShared!)"
        wrongCountLabel.text = "틀린 횟수 : \(wrongNumber)"
    }
    
    func check(_ count: Int, wrong: Int) {
        if count == 16 || wrong == 3 {
            let resultViewController = ResultViewController()
            resultViewController.modalPresentationStyle = .fullScreen
            present(resultViewController, animated: true, completion: nil)
        }
    }
    
    func settingCollection() {
        numberCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.cellId)
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
    }
    
    func settingUI() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            $0.centerX.equalToSuperview()
        }
        view.addSubview(selectNumberLabel)
        selectNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.2)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(numberCollectionView)
        numberCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.4)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        view.addSubview(wrongCountLabel)
        wrongCountLabel.snp.makeConstraints {
            $0.top.equalTo(selectNumberLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
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
        layout.sectionInset = UIEdgeInsets(top: 3, left: 1, bottom: 3, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.invalidateLayout()
        return CGSize(width: (UIScreen.main.bounds.width*0.4)/2, height: (UIScreen.main.bounds.width*0.4)/2)
        
    }
    
    // 셀 선택시 인덱스 받아오는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(randomNumberShared!)
        print(indexPath.row+1)
        if tappedNumbers.contains(indexPath.row+1) || indexPath.row+1 != randomNumberShared! {
            wrongNumber += 1
            wrongCountLabel.text = "틀린 횟수 : \(wrongNumber)"
            check(count, wrong: wrongNumber)
        } else if indexPath.row+1 == randomNumberShared!{
            wrongNumber = 0
            tappedNumbers.append(randomNumberShared!)
            
            let cell = collectionView.cellForItem(at: indexPath)!
            cell.contentView.backgroundColor = .gray
            if let firstIndex = numbers.firstIndex(of: indexPath.row+1) {
                print("삭제됨")
                numbers.remove(at: firstIndex)
            }
            count += 1
            check(count, wrong: wrongNumber)
            settingLabel()
        }
        
    }
}
