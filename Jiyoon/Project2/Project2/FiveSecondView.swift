//
//  FiveSecondView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/05.
//

import Foundation
import UIKit

class FiveSecondView: UIView, CAAnimationDelegate {
    let path = UIBezierPath()
    let innerRadius: CGFloat = 175
    let outerRadius: CGFloat = 190
    let numTicks: Double = 48
    
    override func draw(_ rect: CGRect) {
        for i in 0...600 {
            if i % 5 == 0 {
                let angle = CGFloat(2.0 * .pi * Double(i) / numTicks)
                let inner = CGPoint(x: innerRadius * cos(angle)+200, y: innerRadius * sin(angle)+230)
                let outer = CGPoint(x: outerRadius * cos(angle)+200, y: outerRadius * sin(angle)+230)
                path.move(to: inner)
                path.addLine(to: outer)
                UIColor.gray.set()
                path.stroke()
            }
        }
    }
   
}
