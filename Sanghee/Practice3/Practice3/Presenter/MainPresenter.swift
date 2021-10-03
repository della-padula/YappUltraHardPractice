//
//  MainPresenter.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import UIKit

protocol MainView: AnyObject {
    func setHeader()
    func setMainUnitView()
}

protocol MainViewPresenter {
    func getMainUnitViews()
}

class MainPresenter: MainViewPresenter {
    var mainUnitViews: [MainUnitView] = []
    
    init() {
        getMainUnitViews()
    }
    
    func getMainUnitViews() {
        let mainUnitView = MainUnitView()
        mainUnitView.mainUnit = MainUnit(title: "이번 주 추천 앱", subTitle: "고르고 골랐어요", backgroundColor: .systemGreen)
        mainUnitViews = [mainUnitView, mainUnitView]
    }
}
