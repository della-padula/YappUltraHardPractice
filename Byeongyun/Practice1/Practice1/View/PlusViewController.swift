//
//  PlusViewController.swift
//  Practice1
//
//  Created by ITlearning on 2021/09/16.
//

import UIKit
import SnapKit

class PlusViewController: UIViewController {

    let mainVC = MainViewController()
    
    let plusTitle: UILabel = {
        let label = UILabel()
        label.text = "피드 남기기"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    
    let imageViewer = UIImageView()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "사진과 함께 남길 말을 입력하세요."
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        settingUI()
        
    }
    
    func settingUI() {
        view.addSubview(plusTitle)
        plusTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            
        }
        
        view.addSubview(imageViewer)
        imageViewer.snp.makeConstraints {
            $0.top.equalTo(plusTitle.snp.bottom).offset(20)
            $0.height.equalTo(200)
            $0.width.equalTo(200)
        }
    }
    
}
