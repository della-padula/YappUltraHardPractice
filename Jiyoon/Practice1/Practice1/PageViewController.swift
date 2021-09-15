//
//  PageControl.swift
//  Practice1
//
//  Created by 박지윤 on 2021/09/15.
//

import Foundation
import SnapKit

class PageViewController: UIViewController{
    var locationName = UILabel()
    var locationTemp = UILabel()
    let temperatures = UIStackView()
    var tempHigh = UILabel()
    var tempLow = UILabel()
    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(locationName)
        view.addSubview(locationTemp)
        view.addSubview(temperatures)
        
        backButton.setBackgroundImage(UIImage(systemName: "list.bullet")?.withTintColor(.black), for: .normal)
        backButton.addTarget(self, action: #selector(tappedBack) , for: .touchUpInside)
        view.addSubview(backButton)
        
        temperatures.addArrangedSubview(tempHigh)
        temperatures.addArrangedSubview(tempLow)
        temperatures.alignment = .center
        
        locationName.font = UIFont.systemFont(ofSize: 30)
        locationTemp.font = UIFont.systemFont(ofSize: 80)
        tempHigh.font = UIFont.systemFont(ofSize: 15)
        tempLow.font = UIFont.systemFont(ofSize: 15)
        
        locationName.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        locationTemp.snp.makeConstraints { maker in
            maker.top.equalTo(locationName.snp.bottom).offset(3)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        temperatures.snp.makeConstraints { maker in
            maker.top.equalTo(locationTemp.snp.bottom)
            maker.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        tempHigh.snp.makeConstraints { maker in
            maker.top.equalTo(locationTemp.snp.bottom)
        }
        tempLow.snp.makeConstraints { maker in
            maker.top.equalTo(locationTemp.snp.bottom)
        }
        backButton.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-50)
            maker.height.equalTo(CGSize(width: 30, height: 30))
            maker.width.equalTo(CGSize(width: 30, height: 30))
        }
    }
    @objc
    func tappedBack(){
        dismiss(animated: true, completion: nil)
    }

    
}
