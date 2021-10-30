//
//  DetailViewController.swift
//  Project3
//
//  Created by 박지윤 on 2021/10/03.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    let imageModel = Model()
    var cellView = UIImageView()
    
    override func viewDidLoad() {
        view.backgroundColor = .cyan
    }
    
    func setImage() {
        cellView = {
            let view = UIImageView(image: imageModel.images[0])
            return view
        }()
        cellView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
