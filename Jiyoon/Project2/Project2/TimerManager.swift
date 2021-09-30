//
//  TimerManager.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import Foundation
class TimerManager {
    func createTimer() {
        var timer: Timer?
        var runCount = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { param in
            runCount += 1
            self.makeTimeLabel(count: runCount)
        })
//        DispatchQueue.main.async{
//            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { param in
//                runCount += 1
//                }
//            })
        }
    func makeTimeLabel(count: Int) -> (String) {
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

//extension Notification.Name {
//    static let timesUp = Notification.Name("timesUp")
