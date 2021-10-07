//
//  ViewController.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//
import SnapKit
import UIKit

class TimerViewController: UIViewController {
    private var flag = false
    private var mainTimer:Timer?
    private var runCount = 0
    private var minuite: Int = 0
    private var second: Int = 0
    private var milliSecond: Int = 0
    private var minuteView = UIView()
    
    private let milliSecondView = UIView()
    private let centerView = UIView()
    private let secondLine = UIBezierPath()
    
    private var secondHandView = SecondClockHand()
    private var minuteHandView = MinuteClockHand()
    var minuteCircleView = MinuteView()
    
    var timerLabel = UILabel()
    
    //MARK: - SetSmallLabel
    private let smallLabel5 : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let smallLabel10 : UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let smallLabel15 : UILabel = {
        let label = UILabel()
        label.text = "15"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let smallLabel20 : UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let smallLabel25 : UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let smallLabel30 : UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitle("Stop", for: .selected)
        button.setTitleColor(.green, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 1
        return button
    }()
    
    private let lapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = .black
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 1
        return button
    }()

    override func viewDidLoad() {
            minuteCircleView = MinuteView(frame: self.view.frame)
            setLabel()
            super.viewDidLoad()
            
    }
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(minuteCircleView)
        minuteCircleView.backgroundColor = .clear
    }
    override func viewDidAppear(_ animated: Bool) {
        setTimer()
        setButton()
    }
    func setTimer() {
        timerLabel = {
            let label = UILabel(frame: CGRect(x: 0, y: -TimerLocationInfo.shared.timerCenterY/2 + 30, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            label.textAlignment = .center
            label.text = "00:00:00"
            label.textColor = .white
            label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: UIFont.Weight.light)
            return label
        }()
        view.addSubview(timerLabel)
    }
    
    func setLabel() {
        let secondCircleView = SecondView(frame: view.frame)
        let fiveSecondCircleView = FiveSecondView(frame: view.frame)
        
        [secondCircleView,fiveSecondCircleView, lapButton, secondHandView, minuteHandView].forEach{view.addSubview($0)}
    
        secondHandView.backgroundColor = .clear
        minuteHandView.backgroundColor = .clear
        fiveSecondCircleView.backgroundColor = .clear
        secondCircleView.backgroundColor = .clear

        secondHandView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 2)
            $0.width.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        minuteHandView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-273)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 2)
            $0.width.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func setButton() {
        [startButton, lapButton].forEach { view.addSubview($0) }
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(430)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        startButton.addTarget(self, action: #selector(isButtonTapped), for: .touchUpInside)
        
        lapButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(430)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
    }
    
    @objc
    func isButtonTapped() {
        flag = !flag
        if flag {
            startTimer()
            startButton.isSelected = true
            startButton.layer.borderColor = UIColor.red.cgColor
        } else {
            stopTimer()
            startButton.isSelected = false
            startButton.layer.borderColor = UIColor.green.cgColor
        }
    }
        
    @objc
    private func secondTimerProcess(_ sender: Timer) {
        runCount += 1
        timerLabel.text = self.makeTimeLabel(count: runCount)
        
        let minuteAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(minuite) / 30))
        let secondAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(second) / 60))

        SecondClockHand.animate(withDuration: 2) {
            self.secondHandView.transform = secondAngle
        }
        MinuteClockHand.animate(withDuration: 2) {
            self.minuteHandView.transform = minuteAngle
        }
    }
}

extension TimerViewController {
    private func startTimer() {
        mainTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(secondTimerProcess), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
    
    private func makeTimeLabel(count: Int) -> (String) {
        let min = (count / (1000 * 60)) % 60
        let sec = (count / 1000) % 60
        let milliSec = count - (min * 60000) - (sec * 1000)
        
        minuite = min
        second = sec
        milliSecond = milliSec
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        
        var milliSecString: String
        milliSecString = "\(milliSec/10)".count == 1 ? "0\(milliSec/10)" : "\(milliSec/10)"
        return ("\(minString):\(secString).\(milliSecString)")
    }
}
