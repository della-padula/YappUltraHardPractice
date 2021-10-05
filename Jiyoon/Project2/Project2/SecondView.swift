//
//  CircleView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/01.
//

import Foundation
import UIKit

class SecondView: UIView, CAAnimationDelegate {
    let path = UIBezierPath()
//    var innerRadius: CGFloat = 180
//    var outerRadius: CGFloat = 190
    var innerRadius = CGFloat()
    var outerRadius = CGFloat()
    let numTicks: Double = 240
    
    let smallInnerRadius: CGFloat = 45
    let smallOuterRadius: CGFloat = 50
    let smallNumTicks: Double = 60
    
    var x = CGFloat()
    var y = CGFloat()
    
    override func draw(_ rect: CGRect) {
        x = (superview?.frame.width)!/2
        y = (superview?.frame.height)!/3.5
        innerRadius = (superview?.frame.width)! * 0.43
        outerRadius = innerRadius + 10
        for i in 0...600 {
            if i % 50 != 0 {
                let angle = CGFloat(2.0 * .pi * Double(i) / numTicks)
                let inner = CGPoint(x: innerRadius * cos(angle)+x, y: innerRadius * sin(angle)+y)
                let outer = CGPoint(x: outerRadius * cos(angle)+x, y: outerRadius * sin(angle)+y)
//                let inner = CGPoint(x: innerRadius * cos(angle)+200, y: innerRadius * sin(angle)+230)
//                let outer = CGPoint(x: outerRadius * cos(angle)+200, y: outerRadius * sin(angle)+230)
                path.move(to: inner)
                path.addLine(to: outer)
                UIColor.gray.set()
                path.stroke()
            }
        }
        for i in 0...300 {
//            if i % 50 != 0 {
                let angle = CGFloat(2.0 * .pi * Double(i) / smallNumTicks)
                let inner = CGPoint(x: smallInnerRadius * cos(angle)+200, y: smallInnerRadius * sin(angle)+150)
                let outer = CGPoint(x: smallOuterRadius * cos(angle)+200, y: smallOuterRadius * sin(angle)+150)
                path.move(to: inner)
                path.addLine(to: outer)
                UIColor.gray.set()
                path.stroke()
//            }
        }
    }
   
}
