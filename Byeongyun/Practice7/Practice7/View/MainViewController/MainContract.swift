//
//  MainContract.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func updateTableView()
}

protocol MainPresenterProtocol: AnyObject {
    func fetchVideoList()
    func getVideoList() -> [VideoContent]
}

protocol MainModelProtocol: AnyObject {
    func applyList(contents: [VideoContent])
    func getList() -> [VideoContent]
}
