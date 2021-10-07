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
    var innerRadius = CGFloat()
    var outerRadius = CGFloat()
    let numTicks: Double = 240
    
    var smallInnerRadius = CGFloat()
    var smallOuterRadius = CGFloat()
    let smallNumTicks: Double = 60
    
    var x = CGFloat()
    var y = CGFloat()
    var smallX = CGFloat()
    var smallY = CGFloat()
    
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
            path.move(to: inner)
            path.addLine(to: outer)
            UIColor.gray.set()
            path.stroke()
            }
        }
        
        smallX = (superview?.frame.width)!/2
        smallY = (superview?.frame.height)!/5.6
        
        smallInnerRadius = (superview?.frame.width)! * 0.1
        smallOuterRadius = smallInnerRadius + 5
        
        for i in 0...300 {
            let angle = CGFloat(2.0 * .pi * Double(i) / smallNumTicks)
            let inner = CGPoint(x: smallInnerRadius * cos(angle)+smallX, y: smallInnerRadius * sin(angle)+smallY)
            let outer = CGPoint(x: smallOuterRadius * cos(angle)+smallX, y: smallOuterRadius * sin(angle)+smallY)
            path.move(to: inner)
            path.addLine(to: outer)
            UIColor.gray.set()
            path.stroke()
        }
    }
   
}
