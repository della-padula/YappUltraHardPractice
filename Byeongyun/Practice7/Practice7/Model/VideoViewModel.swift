//
//  VideoViewModel.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/23.
//

import Foundation

class VideoViewModel: VideoModelProtocol {

    private var contentList: [VideoContent] = []

    func applyVideoList(contents: [VideoContent]) {
        contentList = contents
    }

    func getVideoList() -> [VideoContent] {
        return contentList
    }

}
