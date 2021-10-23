//
//  Presenter.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/03.
//

import Foundation

protocol ViewProtocol {
    func loadImage(index: Int) -> String
    func loadMainString(index: Int) -> String
    func loadSubString(index: Int) -> String
    func loadImageCount() -> Int
    func loadExplain(index: Int) -> String
}

class Presenter: NSObject, ViewProtocol {
    let dummy = Dummy()
    let transition = Transition()

    func loadImage(index: Int) -> String {
        dummy.dummyData[index].image
    }
    
    func loadMainString(index: Int) -> String {
        dummy.dummyData[index].mainTitle
    }
    
    func loadSubString(index: Int) -> String {
        dummy.dummyData[index].subTitle
    }
    
    func loadImageCount() -> Int {
        dummy.dummyData.count
    }
    
    func loadExplain(index: Int) -> String {
        dummy.dummyData[index].explainText
    }
}
