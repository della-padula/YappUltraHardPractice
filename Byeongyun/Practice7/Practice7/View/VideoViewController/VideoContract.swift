//
//  VideoContract.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

protocol VideoViewProtocol: AnyObject {
    func playVideo()
}

protocol VideoPresenterProtocol: AnyObject {
    func loadVideo()
    func getVideo()
}

protocol VideoModelProtocol: AnyObject {
    func applyVideoList()
    func getVideoList()
}
