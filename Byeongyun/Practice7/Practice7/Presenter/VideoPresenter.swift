//
//  VideoPresenter.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/23.
//

import Foundation

class VideoPresenter: VideoPresenterProtocol {

    private var view: VideoViewProtocol
    private let service: VideoViewService = VideoViewService()
    private let model: VideoModelProtocol = VideoViewModel()
    
    init(view: VideoViewProtocol) {
        self.view = view
    }

    func loadVideoList() {
        model.applyVideoList(contents: VideoViewService.getVideoList())
        //view.updateCurrentPlayer()
    }

    func setVideoIndex(_ index: Int) {
        VideoViewService.setVideoIndex(index)
    }

    func getVideo() -> [VideoContent] {
        return model.getVideoList()
    }


}
