//
//  TimerCenterInfo.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/06.
//

import Foundation
import UIKit

class TimerLocationInfo {
    static var shared = TimerLocationInfo()
    
    var timerCenterX = CGFloat()
    var timerCenterY = CGFloat()
    
    private init() { }
}
