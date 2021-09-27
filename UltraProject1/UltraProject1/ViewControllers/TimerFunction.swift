//
//  TimerFunction.swift
//  UltraProject1
//
//  Created by 박지윤 on 2021/09/27.
//

import Foundation
class TimerFunction {
    static var timer: Timer?

    static var runCount = 120000

    static func createTimer() {
        TimerFunction.timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
            if TimerFunction.runCount == 0{
                timer?.invalidate()
            }
            TimerFunction.runCount -= 1
            DispatchQueue.main.async {
                let timeString = TimerFunction.makeTimeLabel(count: TimerFunction.runCount)
                GameViewController.timeLabel.text = timeString
            }
        })
    }
    static func makeTimeLabel(count: Int) -> (String) {
        let min = (count / (1000 * 60)) % 60
        let sec = (count / 1000) % 60
        let milliSec = count - (min * 60000) - (sec * 1000)
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        let milliSecString = "\(milliSec)".count == 1 ? "0\(milliSec)" : "\(milliSec)"
        return ("남은 시간: \(minString):\(secString):\(milliSecString)")
    }
}
