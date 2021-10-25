//
//  YouTubeModel.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

class MainViewModel: MainModelProtocol {
    private var contentList: [VideoContent] = []

    func getList() -> [VideoContent] {
        return contentList
    }

    func applyList(contents: [VideoContent]) {
        contentList = contents
    }


}
