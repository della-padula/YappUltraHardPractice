//
//  ViewController.swift
//  Practice2
//
//  Created by ITlearning on 2021/09/30.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Image Picker"
        return label
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("사진 선택", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(selectAction), for: .touchUpInside)
        return button
    }()
    
    @objc
    func selectAction() {
        print("눌림")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        settingUI()
    }
    
    private func settingUI() {
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
    }

}
