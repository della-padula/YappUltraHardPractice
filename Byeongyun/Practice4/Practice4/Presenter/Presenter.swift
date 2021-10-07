//
//  Presenter.swift
//  Practice4
//
//  Created by ITlearning on 2021/10/07.
//

import UIKit

protocol ViewProtocol {
    func loadCoverImage() -> UIImage
    func loadSong() -> NSDataAsset
    func loadBackgound() -> UIImage
    func parseLyrics() -> Dictionary<Double, String>
    func loadLyricTimeArray(_ time: Double) -> Int
    func loadLyricArray(_ index: Int) -> String
    func lyricTimeArrayCount() -> Int
}


class Presenter: NSObject, ViewProtocol {
    let model = Model()
    
    private var albumCoverImage: UIImage {
        guard let albumCover = model.albumCover else { return UIImage() }
        return albumCover
    }
    
    private var backgroundImage: UIImage {
        guard let backgroundImage = model.background else { return UIImage() }
        return backgroundImage
    }
    
    private var song: NSDataAsset {
        guard let song = model.song else { return NSDataAsset(name: "")! }
        return song
    }
    
    func loadCoverImage() -> UIImage {
        return albumCoverImage
    }
    
    func loadSong() -> NSDataAsset {
        return song
    }
    
    func loadBackgound() -> UIImage {
        return backgroundImage
    }
    
    func parseLyrics() -> Dictionary<Double, String> {
        model.lyricParse()
        return model.lyricDic
    }
    
    func loadLyricTimeArray(_ time: Double) -> Int {
        guard let time = model.lyricTimeArray.firstIndex(of: time) else { return Int() }
        return time
    }
    
    func loadLyricArray(_ index: Int) -> String {
        return model.lyricArray[index]
    }
    
    func lyricTimeArrayCount() -> Int {
        return model.lyricTimeArray.count
    }
    
}
