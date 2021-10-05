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
    static var centerY: Double = 0
    static var centerX: Double = 0
    
    //MARK: - SetBigLabel
    private let label5: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label10: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label15: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label20: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label25: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label30: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label35: UILabel = {
        let label = UILabel()
        label.text = "35"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label40: UILabel = {
        let label = UILabel()
        label.text = "40"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label45: UILabel = {
        let label = UILabel()
        label.text = "45"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label50: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label55: UILabel = {
        let label = UILabel()
        label.text = "55"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let label60 : UILabel = {
        let label = UILabel()
        label.text = "60"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: UIFont.Weight.light)
        return label
    }()
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
        super.viewDidLoad()
        setLabel()
        setButton()
    }
    
    func setLabel() {
        let secondCircleView = SecondView(frame: view.frame)
        let fiveSecondCircleView = FiveSecondView(frame: view.frame)
        let minuteCircleView = MinuteView(frame: view.frame)
        [secondCircleView,fiveSecondCircleView, minuteCircleView, timerLabel, lapButton, secondHandView, minuteHandView].forEach{view.addSubview($0)}
        [label5, label10, label15, label20, label25, label30, label35, label40, label45, label50, label55, label60].forEach{view.addSubview($0)}
        
        [smallLabel5, smallLabel10, smallLabel15, smallLabel20, smallLabel25, smallLabel30].forEach{view.addSubview($0)}
        
        minuteCircleView.backgroundColor = .clear
        secondHandView.backgroundColor = .clear
        minuteHandView.backgroundColor = .clear
        fiveSecondCircleView.backgroundColor = .clear
        secondCircleView.backgroundColor = .clear
        
        label60.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.centerX.equalToSuperview()
        }
        label55.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75)
            $0.centerX.equalToSuperview().offset(-80)
        }
        label5.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75)
            $0.centerX.equalToSuperview().offset(80)
        }
        label10.snp.makeConstraints {
            $0.top.equalToSuperview().offset(135)
            $0.centerX.equalToSuperview().offset(130)
        }
        label50.snp.makeConstraints {
            $0.top.equalToSuperview().offset(135)
            $0.centerX.equalToSuperview().offset(-130)
        }
        label45.snp.makeConstraints {
            $0.top.equalToSuperview().offset(210)
            $0.centerX.equalToSuperview().offset(-150)
        }
        label15.snp.makeConstraints {
            $0.top.equalToSuperview().offset(210)
            $0.centerX.equalToSuperview().offset(150)
        }
        label40.snp.makeConstraints {
            $0.top.equalToSuperview().offset(290)
            $0.centerX.equalToSuperview().offset(-130)
        }
        label20.snp.makeConstraints {
            $0.top.equalToSuperview().offset(290)
            $0.centerX.equalToSuperview().offset(130)
        }
        label35.snp.makeConstraints {
            $0.top.equalToSuperview().offset(340)
            $0.centerX.equalToSuperview().offset(-85)
        }
        label25.snp.makeConstraints {
            $0.top.equalToSuperview().offset(340)
            $0.centerX.equalToSuperview().offset(85)
        }
        label30.snp.makeConstraints {
            $0.top.equalToSuperview().offset(365)
            $0.centerX.equalToSuperview()
        }
        
        smallLabel30.snp.makeConstraints {
            $0.top.equalToSuperview().offset(118)
            $0.centerX.equalToSuperview().offset(5)
        }
        smallLabel5.snp.makeConstraints {
            $0.top.equalToSuperview().offset(125)
            $0.centerX.equalToSuperview().offset(28)
        }
        smallLabel25.snp.makeConstraints {
            $0.top.equalToSuperview().offset(125)
            $0.centerX.equalToSuperview().offset(-20)
        }
        smallLabel10.snp.makeConstraints {
            $0.top.equalToSuperview().offset(155)
            $0.centerX.equalToSuperview().offset(28)
        }
        smallLabel20.snp.makeConstraints {
            $0.top.equalToSuperview().offset(155)
            $0.centerX.equalToSuperview().offset(-20)
        }
        smallLabel15.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview().offset(5)
        }
        
        
        timerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.centerX.equalToSuperview()
        }
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
        
        minuite = 10
        second = sec
        milliSecond = milliSec
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        
        var milliSecString: String
        milliSecString = "\(milliSec/10)".count == 1 ? "0\(milliSec/10)" : "\(milliSec/10)"
        return ("\(minString):\(secString).\(milliSecString)")
    }
}
