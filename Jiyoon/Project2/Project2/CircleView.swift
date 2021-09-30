//
//  CircleView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import Foundation
import UIKit

class CircleView: UIView {
    let onePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
    let fiveWhitePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
    let fiveGrayPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 50, width: 380, height: 380))
    let onePattern: [CGFloat] = [3, 50]
    let fiveWhitePattern: [CGFloat] = [3, 97]
    let fiveGrayPattern: [CGFloat] = [3, 25]
    let line = UIBezierPath()
   
    override func draw(_ rect: CGRect) {
        onePath.setLineDash(onePattern, count: onePattern.count, phase: 0)
        onePath.lineWidth = 5
        onePath.move(to: CGPoint(x: 0, y: 0))
        UIColor.gray.set()
        onePath.stroke()
        
        fiveGrayPath.setLineDash(fiveWhitePattern, count: fiveWhitePattern.count, phase: 0)
        fiveWhitePath.lineWidth = 5
        fiveWhitePath.move(to: CGPoint(x: 0, y: 0))
        UIColor.gray.set()
        fiveWhitePath.stroke()
        
        fiveWhitePath.setLineDash(fiveWhitePattern, count: fiveWhitePattern.count, phase: 1)
        fiveWhitePath.lineWidth = 30
        fiveWhitePath.move(to: CGPoint(x: 0, y: 0))
        UIColor.white.set()
        fiveWhitePath.stroke()
        
        line.lineWidth = 2
        line.move(to: CGPoint(x: 170, y: 280))
        line.addLine(to: CGPoint(x: 300, y: 80))
        UIColor.orange.set()
        line.stroke()
    }
}
