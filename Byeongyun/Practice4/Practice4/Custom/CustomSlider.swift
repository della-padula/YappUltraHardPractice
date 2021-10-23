//
//  CustomSlider.swift
//  Practice4
//
//  Created by ITlearning on 2021/10/06.
//

import UIKit

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: 10))
    }
}
