//
//  GraphView.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/15.
//

import UIKit

class GraphView: UIView {

    private var values: [CGFloat] = []

    init(frame: CGRect, values: [CGFloat]) {
        super.init(frame: frame)
        self.values = values
        print(self.values)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let layer = CAShapeLayer()
        let path = UIBezierPath()

        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        var currentX: CGFloat = 0
        path.move(to: CGPoint(x: currentX, y: self.frame.height))

        for i in 0..<values.count {
            currentX += xOffset
            if self.values[i] > self.frame.height {
                print(self.values[i])
                let newPosition: CGPoint = CGPoint(x: currentX, y: self.frame.height - self.values[i]/6)
                path.addLine(to: newPosition)
            } else if self.values[i] < 100 {
                let newPosition: CGPoint = CGPoint(x: currentX, y: self.frame.height - self.values[i]*2)
                path.addLine(to: newPosition)
            } else {
                let newPosition: CGPoint = CGPoint(x: currentX, y: self.frame.height - self.values[i])
                path.addLine(to: newPosition)
            }

        }

        layer.fillColor = nil
        layer.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        layer.lineWidth = 2
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    }
}
