//
//  MinuteClockHand.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/05.
//

import Foundation
import UIKit

class MinuteClockHand: UIView {
    let minuteLine = UIBezierPath()
    override func draw(_ rect: CGRect) {
        minuteLine.lineWidth = 2
        minuteLine.move(to: CGPoint(x: 200, y: 220))
        minuteLine.addLine(to: CGPoint(x: 200, y: 170))
        UIColor.orange.set()
        minuteLine.stroke()
    }
}
