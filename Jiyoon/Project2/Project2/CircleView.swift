//
//  CircleView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import Foundation
import UIKit

class CircleView: UIView, CAAnimationDelegate {
//    let onePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
//    let fiveWhitePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
//    let onePattern: [CGFloat] = [1, 5]
//    let fiveWhitePattern: [CGFloat] = [3, 97]
//    var animations: [CABasicAnimation] = [CABasicAnimation]()
//    var minuite: Int = 0
//    var second: Int = 0
//    var milliSecond: Int = 0
//
//    override func draw(_ rect: CGRect) {
//        onePath.setLineDash(onePattern, count: onePattern.count, phase: 0)
//        onePath.lineWidth = 10
//        onePath.move(to: CGPoint(x: 0, y: 0))
//        onePath.copy(dashingWithPhase: 0, lengths: [(.pi * 50) / 60])
//        UIColor.gray.set()
//        onePath.stroke()
//
//        fiveWhitePath.setLineDash(fiveWhitePattern, count: fiveWhitePattern.count, phase: 1)
//        fiveWhitePath.lineWidth = 30
//        fiveWhitePath.move(to: CGPoint(x: 0, y: 0))
//        UIColor.white.set()
//        fiveWhitePath.stroke()
//    }
    let path = UIBezierPath()
    let innerRadius: CGFloat = 150
    let outerRadius: CGFloat = 180
    let numTicks = 24
    
    override func draw(_ rect: CGRect) {
        for i in 0...60 {
            let angle = CGFloat(i) * CGFloat(2.0 * .pi) / 24 - 10
            let inner = CGPoint(x: innerRadius * cos(angle)+200, y: innerRadius * sin(angle)+240)
            let outer = CGPoint(x: outerRadius * cos(angle)+200, y: outerRadius * sin(angle)+240)
            path.move(to: inner)
            path.addLine(to: outer)
            UIColor.white.set()
            path.stroke()
        }
    }
   
}
