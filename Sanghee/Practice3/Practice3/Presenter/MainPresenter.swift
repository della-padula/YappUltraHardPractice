//
//  MainPresenter.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import UIKit

protocol MainView: AnyObject {
    func setHeader()
}

protocol MainViewPresenter {
    func getMainUnits()
}

class MainPresenter: MainViewPresenter {
    var mainUnits: [MainUnit] = []
    
    init() {
        getMainUnits()
    }
    
    func getMainUnits() {
        mainUnits = [
            MainUnit(title: "이번 주 추천 앱", subTitle: "고르고 골랐어요", backgroundColor: .systemGreen),
            MainUnit(title: "최고의 Apple Arcade 게임", subTitle: "컬렉션", backgroundColor: .systemBlue),
            MainUnit(title: "요즘 화제", subTitle: "iPhone용 Safari 확장 프로그램", backgroundColor: .systemPink),
            MainUnit(title: "에디터도 플레이 중", subTitle: "너무 너무 귀여워!", backgroundColor: .systemYellow)
        ]
    }
}
