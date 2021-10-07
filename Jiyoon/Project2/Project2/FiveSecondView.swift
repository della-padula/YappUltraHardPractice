//
//  FiveSecondView.swift
//  Project2
//
//  Created by 박지윤 on 2021/10/05.
//

import Foundation
import SnapKit
import UIKit

class FiveSecondView: UIView, CAAnimationDelegate {
    let path = UIBezierPath()
    var view = UIView()
    var innerRadius = CGFloat()
    var outerRadius = CGFloat()
    let numTicks: Double = 48
    
    var smallInnerRadius = CGFloat()
    var smallOuterRadius = CGFloat()
    let smallNumTicks: Double = 12
    
    var x = CGFloat()
    var y = CGFloat()
    var smallX = CGFloat()
    var smallY = CGFloat()
    
    override func draw(_ rect: CGRect) {
        self.addSubview(view)
        x = (superview?.frame.width)!/2
        y = (superview?.frame.height)!/3.5
        smallX = (superview?.frame.width)!/2
        smallY = (superview?.frame.height)!/5.6
        
        innerRadius = (superview?.frame.width)! * 0.41
        outerRadius = innerRadius + 15
        smallInnerRadius = (superview?.frame.width)! * 0.08
        smallOuterRadius = smallInnerRadius + 10
        for i in 0...600 {
            if i % 5 == 0 {
                let angle = CGFloat(2.0 * .pi * Double(i) / numTicks)
                let inner = CGPoint(x: innerRadius * cos(angle)+x, y: innerRadius * sin(angle)+y)
                let outer = CGPoint(x: outerRadius * cos(angle)+x, y: outerRadius * sin(angle)+y)
                path.move(to: inner)
                path.addLine(to: outer)
                UIColor.gray.set()
                path.stroke()
            }
        }
        for j in 0...60 {
            if j % 5 == 0{
                let angle = CGFloat(2.0 * .pi * Double(j) / smallNumTicks)
                let inner = CGPoint(x: smallInnerRadius * cos(angle)+smallX, y: smallInnerRadius * sin(angle)+smallY)
                let outer = CGPoint(x: smallOuterRadius * cos(angle)+smallX, y: smallOuterRadius * sin(angle)+smallY)
                path.move(to: inner)
                path.addLine(to: outer)
                UIColor.systemPink.set()
                path.stroke()
                let fiveMinuteNumLabel = UILabel(frame: CGRect(
                    x: smallInnerRadius * 0.3 * cos(angle)+smallX-20,
                    y:innerRadius * 0.3 * sin(angle)+smallY-22,
                    width: 40,
                    height: 20))
                    fiveMinuteNumLabel.text = "\(j)"
                    fiveMinuteNumLabel.font = UIFont.systemFont(ofSize: 15)
                    fiveMinuteNumLabel.textColor = .white
            view.addSubview(fiveMinuteNumLabel)
            }
        }
    }
}
