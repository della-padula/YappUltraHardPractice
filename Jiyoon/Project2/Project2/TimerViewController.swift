//
//  ViewController.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//
import SnapKit
import UIKit

class TimerViewController: UIViewController {
    var flag = false
    var mainTimer:Timer?
    var runCount = 0
    var minuite: Int = 0
    var second: Int = 0
    var milliSecond: Int = 0
    var minuteView = UIView()
    
    var milliSecondView = UIView()
    var centerView = UIView()
    let secondLine = UIBezierPath()
    
    let handView = ClockHand()
    
    //MARK: - SetLabel
    private let label5: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label10: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label15: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label20: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label25: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label30: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label35: UILabel = {
        let label = UILabel()
        label.text = "35"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label40: UILabel = {
        let label = UILabel()
        label.text = "40"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label45: UILabel = {
        let label = UILabel()
        label.text = "45"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label50: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label55: UILabel = {
        let label = UILabel()
        label.text = "55"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let label60 : UILabel = {
        let label = UILabel()
        label.text = "60"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: UIFont.Weight.light)
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
        view.backgroundColor = .white
        setLabel()
        setButton()
    }
    
    func setLabel() {
        let circle = CircleView(frame: view.frame)
        [circle, label5, label10, label15, label20, label25, label30, label35, label40, label45, label50, label55, label60, timerLabel].forEach{view.addSubview($0)}
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(lapButton)
        
        handView.backgroundColor = .clear
        view.addSubview(handView)
        
        label60.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.centerX.equalToSuperview()
        }
        label55.snp.makeConstraints {
            $0.top.equalToSuperview().offset(85)
            $0.centerX.equalToSuperview().offset(-90)
        }
        label5.snp.makeConstraints {
            $0.top.equalToSuperview().offset(85)
            $0.centerX.equalToSuperview().offset(90)
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
            $0.centerX.equalToSuperview().offset(-160)
        }
        label15.snp.makeConstraints {
            $0.top.equalToSuperview().offset(210)
            $0.centerX.equalToSuperview().offset(160)
        }
        label40.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.centerX.equalToSuperview().offset(-130)
        }
        label20.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.centerX.equalToSuperview().offset(130)
        }
        label35.snp.makeConstraints {
            $0.top.equalToSuperview().offset(350)
            $0.centerX.equalToSuperview().offset(-90)
        }
        label25.snp.makeConstraints {
            $0.top.equalToSuperview().offset(350)
            $0.centerX.equalToSuperview().offset(90)
        }
        label30.snp.makeConstraints {
            $0.top.equalToSuperview().offset(380)
            $0.centerX.equalToSuperview()
        }
        timerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.centerX.equalToSuperview()
        }
        handView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func setButton() {
        [startButton, lapButton].forEach {view.addSubview($0)}
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
    private func initView() {
            // TODO: 시계침 중심 디자인
        self.centerView.layer.cornerRadius = self.centerView.frame.width / 2
    }
        
    @objc
    private func secondTimerProcess(_ sender: Timer) {
        runCount += 1
        timerLabel.text = self.makeTimeLabel(count: runCount)
//        let minuteAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(minuite) / 60))
        let secondAngle = CGAffineTransform(rotationAngle: CGFloat(2.0 * .pi * Double(second) / 60 / 10))

        ClockHand.animate(withDuration: 0) {
            self.handView.transform = secondAngle
            
        }
    }
}

extension TimerViewController {
    func startTimer() {
        mainTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(secondTimerProcess), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
    
    func makeTimeLabel(count: Int) -> (String) {
        let min = (count / (1000 * 60))
        let sec = (count / 1000)
        let milliSec = count - (min * 60000) - (sec * 1000)
        
        minuite = min
        second = sec
        milliSecond = milliSec
        
        CircleView.getTimerNum(minute: minuite, second: second, milliSecond: milliSecond)
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        
        var milliSecString: String
        milliSecString = "\(milliSec/10)".count == 1 ? "0\(milliSec/10)" : "\(milliSec/10)"
        return ("\(minString):\(secString).\(milliSecString)")
    }
}
