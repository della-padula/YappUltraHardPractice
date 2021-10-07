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
    var view = UIView()
//    let innerRadius: CGFloat = 175
//    let outerRadius: CGFloat = 190
    var innerRadius = CGFloat()
    var outerRadius = CGFloat()
    let numTicks: Double = 12
    
    let smallInnerRadius: CGFloat = 40
    let smallOuterRadius: CGFloat = 50
    let smallNumTicks: Double = 6
    
    var x = CGFloat()
    var y = CGFloat()
    var minuteNumLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        self.addSubview(view)
        x = (superview?.frame.width)!/2
        y = (superview?.frame.height)!/3.5
        innerRadius = (superview?.frame.width)! * 0.41
        outerRadius = innerRadius + 15
        for i in 0..<60 {
            if i % 5 == 0{
            let angle = CGFloat(2.0 * .pi * Double(i) / numTicks)
            let inner = CGPoint(x: innerRadius * cos(angle)+x, y: innerRadius * sin(angle)+y)
            let outer = CGPoint(x: outerRadius * cos(angle)+x, y: outerRadius * sin(angle)+y)
            path.move(to: inner)
            path.addLine(to: outer)
            UIColor.white.set()
            path.close()
            let minuteNumLabel = UILabel(frame: CGRect(x: innerRadius * 0.9 * cos(angle)+x-20,
                                           y:innerRadius * 0.9 * sin(angle)+y-22,
                                           width: 40,
                                           height: 40))
            minuteNumLabel.textAlignment = .center
            minuteNumLabel.textColor = .white
            minuteNumLabel.font = UIFont.systemFont(ofSize: 25)
            switch i {
            case 0:
                minuteNumLabel.text = "15"
            case 5:
                minuteNumLabel.text = "40"
            case 10:
                minuteNumLabel.text = "5"
            case 15:
                minuteNumLabel.text = "30"
            case 20:
                minuteNumLabel.text = "55"
            case 25:
                minuteNumLabel.text = "20"
                TimerLocationInfo.shared.timerCenterX = innerRadius * 0.9 * cos(angle)+x-20
                TimerLocationInfo.shared.timerCenterY = innerRadius * 0.9 * sin(angle)+y-22
                print(TimerLocationInfo.shared.timerCenterY)
            case 30:
                minuteNumLabel.text = "45"
            case 35:
                minuteNumLabel.text = "10"
            case 40:
                minuteNumLabel.text = "35"
            case 45:
                minuteNumLabel.text = "60"
            case 50:
                minuteNumLabel.text = "25"
            case 55:
                minuteNumLabel.text = "50"
            default:
                minuteNumLabel.text = ""
            }
            view.addSubview(minuteNumLabel)
                
        for j in 0...60 {
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
}
