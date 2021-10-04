//
//  MinuteView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/05.
//

import Foundation
import UIKit

class MinuteView: UIView, CAAnimationDelegate {
    let path = UIBezierPath()
    let innerRadius: CGFloat = 175
    let outerRadius: CGFloat = 190
    let numTicks: Double = 12
    
    let smallInnerRadius: CGFloat = 40
    let smallOuterRadius: CGFloat = 50
    let smallNumTicks: Double = 6
    
    override func draw(_ rect: CGRect) {
        for i in 0...60 {
            let angle = CGFloat(2.0 * .pi * Double(i) / numTicks)
            let inner = CGPoint(x: innerRadius * cos(angle)+200, y: innerRadius * sin(angle)+230)
            let outer = CGPoint(x: outerRadius * cos(angle)+200, y: outerRadius * sin(angle)+230)
            path.move(to: inner)
            path.addLine(to: outer)
            UIColor.white.set()
            path.stroke()
        }
        for j in 0...60 {
            if j % 1 == 0{
                let angle = CGFloat(2.0 * .pi * Double(j) / smallNumTicks)
                let inner = CGPoint(x: smallInnerRadius * cos(angle)+200, y: smallInnerRadius * sin(angle)+150)
                let outer = CGPoint(x: smallOuterRadius * cos(angle)+200, y: smallOuterRadius * sin(angle)+150)
                path.move(to: inner)
                path.addLine(to: outer)
                UIColor.white.set()
                path.stroke()
            }
        }
    }
}
