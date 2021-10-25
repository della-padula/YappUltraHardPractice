//
//  MainPresenter.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

class MainPresenter: MainPresenterProtocol {

    private var view: MainViewProtocol
    private let service: VideoViewService = VideoViewService()
    private let model: MainModelProtocol = MainViewModel()

    init(view: MainViewProtocol) {
        self.view = view
    }

    func fetchVideoList() {
        model.applyList(contents: VideoViewService.getVideoList())
        view.updateTableView()
    }

    func fetchVideoIndex() -> Int {
        return VideoViewService.getVideoIndex()
    }

    func getVideoList() -> [VideoContent] {
        return model.getList()
    }

}
