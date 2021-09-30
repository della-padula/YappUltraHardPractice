//
//  GameViewController.swift
//  UltraProject1
//
//  Created by ITlearning on 2021/09/27.
//

import UIKit
import SnapKit
class GameViewController: UIViewController {
    private var numbers = Array<Int>(1...16)
    private var sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private var coreData: [Score] = []
    private var tappedNumbers: [Int] = []
    private var timer: Timer?
    private var timerNum: Int = 0
    private var randomNumber: Int = 0
    private var oneTry: Int = 0
    private var twoTry: Int = 0
    private var wrongTry: Int = 0
    private var wrongNumber: Int = 0
    private var count: Int = 0
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "남은 시간"
        label.textAlignment = .center
        return label
    }()
    
    // 수정중
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: UIFont.Weight.regular)
        label.text = "02:00:00"
        return label
    }()
    // 수정중
    var changeTimerLabel: String? {
        didSet {
            guard let change = changeTimerLabel else { return }
            print(change)
            timerLabel.text = change
        }
    }
    
    private let selectNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.width/5)
        label.text = "준비"
        label.textAlignment = .center
        return label
    }()
    
    private let wrongCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "틀린 횟수 : 0"
        label.textAlignment = .center
        label.textColor = .systemGray
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        settingLayout()
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        setCollection()
        setUI()
        TimerManager.createTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(move), name: .timesUp, object: nil)
        settingLayout()
        
    }
    
    @objc
    func move() {
        gameOverCheck(count, wrong: wrongTry)
    }
    
    private func startTimer() {
        if timer != nil && ((timer?.isValid) != nil) {
            timer?.invalidate()
        }
        
        timerNum = 2
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    @objc
    func timerCallBack() {
        waitCountLabel.text = "\(timerNum)"
        if timerNum == 0 {
            timer?.invalidate()
            timer = nil
        }
        timerNum -= 1
    }
    
    private func settingLayout() {
        waitPage()
        startTimer()
        setText()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.waitView.removeFromSuperview()
            self.waitCountLabel.removeFromSuperview()
            self.setLabel()
            self.mixCollectionView()
        }
        
    }

    private func mixCollectionView() {
        numbers.shuffle()
        numberCollectionView.reloadData()
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
    
    private func gameOverCheck(_ count: Int, wrong: Int) {
        // 종료 조건 : 시간이 종료됐을 때
        let resultViewController = ResultViewController()
        resultViewController.navigationController?.isNavigationBarHidden = true
        CoreDataManager.shared.insertGame(Score(total: Int16(count), first: Int16(oneTry), second: Int16(twoTry), wrong: Int16(wrongTry)))
        resultViewController.data = Score(total: Int16(count), first: Int16(oneTry), second: Int16(twoTry), wrong: Int16(wrongTry))
        resultViewController.modalPresentationStyle = .fullScreen
        present(resultViewController, animated: true, completion: nil)
    }
    
    private func setLabel() {
        guard let randomNumber = numbers.randomElement() else { return }
        self.randomNumber = randomNumber
        selectNumberLabel.text = "\(randomNumber)"
        wrongCountLabel.text = "틀린 횟수 : \(wrongNumber)"
    }
    
    private func setText() {
        waitCountLabel.text = "3"
        //timerLabel.text = "02:00:00"
        selectNumberLabel.text = "준비"
        wrongCountLabel.text = "틀린 횟수 : 0"
    }
    
    private func setCollection() {
        numberCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.cellId)
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
    }
    
    private func setUI() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            $0.centerX.equalToSuperview().offset(UIScreen.main.bounds.width * -0.2)
        }
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.leading.equalTo(timeLabel.snp.trailing).offset(20)
            $0.top.equalTo(timeLabel.snp.top)
        }
        view.addSubview(selectNumberLabel)
        selectNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.2)
            $0.centerX.equalToSuperview()
        }
        view.addSubview(numberCollectionView)
        numberCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.4)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
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
        if !numbers.contains(numbers[indexPath.row]) || numbers[indexPath.row] != randomNumber {
            wrongNumber += 1
            wrongCountLabel.text = "틀린 횟수 : \(wrongNumber)"
            if wrongNumber == 3 {
                wrongTry += 1
                wrongNumber = 0
                setLabel()
                mixCollectionView()
            }
        } else if numbers[indexPath.row] == randomNumber {
            if wrongNumber == 1 {
                oneTry += 1
            } else if wrongNumber == 2 {
                twoTry += 1
            }
            wrongNumber = 0
            mixCollectionView()
            count += 1
            setLabel()
        }
    }
}
protocol TimerDelegate {
    var timer: TimerManager { get }
}
