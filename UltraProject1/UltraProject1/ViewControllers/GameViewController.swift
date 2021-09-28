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
        label.text = "남은 시간: "
        label.textAlignment = .center
        return label
    }()
    
    static var timerLabel: UILabel = {
        let label = UILabel()
        
        label.sizeToFit()
        let newSize = label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat(20)))
        label.frame.size.width = newSize.width
        label.frame.size.height = newSize.height
        label.text = "\(TimerFunction.createTimer())"
        return label
    }()
    
    private let selectNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.text = "준비"
        label.textAlignment = .center
        return label
    }()
    
    private let wrongCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "틀린 횟수 : 준비"
        label.textAlignment = .center
        return label
    }()
    
    private let numberCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let waitView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private var waitCountLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 80)
        return label
    }()
    
    private var sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var randomNumberShared: Int?
    var wrongNumber: Int = 0
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingCollection()
        settingUI()
        TimerFunction.createTimer()
        waitPage()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.waitView.removeFromSuperview()
            self.waitCountLabel.removeFromSuperview()
            self.settingLabel()
        }
    }
    
    private func waitPage() {
        view.addSubview(waitView)
        waitView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
        view.addSubview(waitCountLabel)
        waitCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func settingLabel() {
        guard let randomNumber = numbers.randomElement() else { return }
        randomNumberShared = randomNumber
        guard let unwrappedRandomNumberShared = randomNumberShared else { return }
        selectNumberLabel.text = "\(unwrappedRandomNumberShared)"
        wrongCountLabel.text = "틀린 횟수 : \(wrongNumber)"
    }
    
    
    private func gameOverCheck(_ count: Int, wrong: Int) {
        // 종료 조건 : 시간이 종료됐을 때
        if count == 20 {
            let resultViewController = ResultViewController()
            resultViewController.modalPresentationStyle = .fullScreen
            present(resultViewController, animated: true, completion: nil)
        }
    }
    
    private func settingCollection() {
        numberCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.cellId)
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
    }
    
    private func settingUI() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            $0.leading.equalToSuperview().offset(UIScreen.main.bounds.width * 0.3)
        }
        
        view.addSubview(GameViewController.timerLabel)
        GameViewController.timerLabel.snp.makeConstraints {
            $0.leading.equalTo(timeLabel.snp.trailing).offset(20)
            $0.top.equalTo(timeLabel)
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
        
        cell.settingLabel = numbers[indexPath.row]
        return cell
    }
    // 셀 크기 세팅
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        let itemsPerRow: CGFloat = 4
        let widthPadding = sectionInset.left * (itemsPerRow+1)
        let itemsPerCol: CGFloat = 4
        let heightPadding = sectionInset.top * (itemsPerCol+1)
        
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellheight = (height - heightPadding) / itemsPerCol
        
        return CGSize(width: cellWidth, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInset.left
    }
    
    // 셀 선택시 인덱스 받아오는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let unwrappedRandomNumberShared = randomNumberShared else { return }
        print(numbers.contains(numbers[indexPath.row]))
        if !numbers.contains(numbers[indexPath.row]) || numbers[indexPath.row] != unwrappedRandomNumberShared {
            wrongNumber += 1
            wrongCountLabel.text = "틀린 횟수 : \(wrongNumber)"
            gameOverCheck(count, wrong: wrongNumber)
            if wrongNumber == 3 {
                wrongNumber = 0
                settingLabel()
            }
        } else if numbers[indexPath.row] == unwrappedRandomNumberShared {
            wrongNumber = 0
            numbers.shuffle()
            collectionView.reloadData()
            count += 1
            gameOverCheck(count, wrong: wrongNumber)
            settingLabel()
        }
    }
}
