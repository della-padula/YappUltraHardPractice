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
    //MARK: - SetLabel
    var label5: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label10: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label15: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label20: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label25: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label30: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label35: UILabel = {
        let label = UILabel()
        label.text = "35"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label40: UILabel = {
        let label = UILabel()
        label.text = "40"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label45: UILabel = {
        let label = UILabel()
        label.text = "45"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label50: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var label55: UILabel = {
        let label = UILabel()
        label.text = "55"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    let label60 : UILabel = {
        let label = UILabel()
        label.text = "60"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.monospacedSystemFont(ofSize: 25, weight: UIFont.Weight.light)
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.setTitle("중단", for: .selected)
        button.setTitleColor(.green, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let circle = CircleView(frame: view.frame)
        view.addSubview(circle)
        view.addSubview(label60)
        view.addSubview(label55)
        view.addSubview(label5)
        view.addSubview(label10)
        view.addSubview(label50)
        view.addSubview(label45)
        view.addSubview(label15)
        view.addSubview(label40)
        view.addSubview(label20)
        view.addSubview(label35)
        view.addSubview(label25)
        view.addSubview(label30)
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        
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
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(430)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        startButton.addTarget(self, action: #selector(isButtonTapped), for: .touchUpInside)
        
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
}

extension TimerViewController {
    func startTimer() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { [self] param in
            runCount += 1
            timerLabel.text = self.makeTimeLabel(count: runCount)
        })
    
    }
    func stopTimer() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
    func makeTimeLabel(count: Int) -> (String) {
        let min = (count / (1000 * 60))
        let sec = (count / 1000)
        let milliSec = count - (min * 60000) - (sec * 1000)
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        
        var milliSecString: String
        milliSecString = "\(milliSec/10)".count == 1 ? "0\(milliSec/10)" : "\(milliSec/10)"
        return ("\(minString):\(secString).\(milliSecString)")
    }
}
