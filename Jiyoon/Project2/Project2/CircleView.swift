//
//  CircleView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import Foundation
import UIKit

class CircleView: UIView, CAAnimationDelegate {
    let onePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
    let fiveWhitePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
    let onePattern: [CGFloat] = [1, 5]
    let fiveWhitePattern: [CGFloat] = [3, 97]
    let secondLine = UIBezierPath()
    var animations: [CABasicAnimation] = [CABasicAnimation]()
    let handView = UIView()
    var minuite: Int = 0
    var second: Int = 0
    var milliSecond: Int = 0
   
    override func draw(_ rect: CGRect) {
        onePath.setLineDash(onePattern, count: onePattern.count, phase: 0)
        onePath.lineWidth = 10
        onePath.move(to: CGPoint(x: 0, y: 0))
        UIColor.gray.set()
        onePath.stroke()
        
        fiveWhitePath.setLineDash(fiveWhitePattern, count: fiveWhitePattern.count, phase: 1)
        fiveWhitePath.lineWidth = 30
        fiveWhitePath.move(to: CGPoint(x: 0, y: 0))
        UIColor.white.set()
        fiveWhitePath.stroke()
        
//        secondLine.lineWidth = 2
//        secondLine.move(to: CGPoint(x: 200, y: 240))
//        secondLine.addLine(to: CGPoint(x: 201, y: 80))
//        UIColor.orange.set()
//        secondLine.stroke()
    }
    
    func degree2radian(_ number: Double) -> Double {
        return number * .pi / 180
    }
    static func getTimerNum(minute: Int, second: Int, milliSecond: Int) {
        
    }
    
}
