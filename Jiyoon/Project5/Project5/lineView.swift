//
//  lineView.swift
//  Project5
//
//  Created by 박지윤 on 2021/10/15.
//

import Foundation
import UIKit

class lineView: UIView {
    init(_ dict: [String:Int]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        print(dict)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
