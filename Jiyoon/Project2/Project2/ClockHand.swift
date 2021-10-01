//
//  ClockHand.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import Foundation
import UIKit

class ClockHand: UIView {
    let secondLine = UIBezierPath()
    override func draw(_ rect: CGRect) {
        secondLine.lineWidth = 2
        secondLine.move(to: CGPoint(x: 200, y: 240))
        secondLine.addLine(to: CGPoint(x: 201, y: 80))
        UIColor.orange.set()
        secondLine.stroke()
    }
}
