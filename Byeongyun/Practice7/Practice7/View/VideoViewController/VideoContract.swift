//
//  VideoContract.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

protocol VideoViewProtocol: AnyObject {
    func updateCurrentPlayer()
}

protocol VideoPresenterProtocol: AnyObject {
    func loadVideoList()
    func getVideo() -> [VideoContent]
}

protocol VideoModelProtocol: AnyObject {
    func applyVideoList(contents: [VideoContent])
    func getVideoList() -> [VideoContent]
}
