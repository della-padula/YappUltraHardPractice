//
//  YouTubeModel.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

struct VideoContent {
    let videoImage: String
    let channelImage: String
    let videoMainLabel: String
    let profileLabel: String
}

class MainViewModel: MainModelProtocol {
    private var contentList: [VideoContent] = []

    func getList() -> [VideoContent] {
        return contentList
    }

    func applyList(contents: [VideoContent]) {
        contentList = contents
    }


}
