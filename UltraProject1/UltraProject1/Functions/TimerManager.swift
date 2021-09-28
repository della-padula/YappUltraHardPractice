//
//  TimerManager.swift
//  UltraProject1
//
//  Created by 박지윤 on 2021/09/27.
//

import Foundation
class TimerManager {
    static func createTimer() {
        var timer: Timer?
        var runCount = 120000
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { param in
                runCount -= 1
                if runCount <= 0 && timer != nil {
                    param.invalidate()
                    timer = nil
                    NotificationCenter.default.post(name: .timesUp, object: true)
                }
                else {
                    let timeString = makeTimeLabel(count: runCount)
                    GameViewController.timerLabel.text = timeString
                }
            })
        }
    }
    static func makeTimeLabel(count: Int) -> (String) {
        let min = (count / (1000 * 60)) % 60
        let sec = (count / 1000) % 60
        let milliSec = count - (min * 60000) - (sec * 1000)
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        
        var milliSecString: String
        milliSecString = "\(milliSec/10)".count == 1 ? "0\(milliSec/10)" : "\(milliSec/10)"
        return ("\(minString):\(secString):\(milliSecString)")
    }
}

extension Notification.Name {
    static let timesUp = Notification.Name("timesUp")
}
