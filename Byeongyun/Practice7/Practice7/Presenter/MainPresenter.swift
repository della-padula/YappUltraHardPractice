//
//  MainPresenter.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    func fetchVideoList() {
        model.applyList(contents: MainViewService.getVideoList())
        view.updateTableView()
    }

    func getVideoList() -> [VideoContent] {
        return model.getList()
    }

    private var view: MainViewProtocol
    private let service: MainViewService = MainViewService()
    private let model: MainModelProtocol = MainViewModel()
    init(view: MainViewProtocol) {
        self.view = view
    }


}
