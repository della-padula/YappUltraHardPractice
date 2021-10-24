//
//  VIdeoLauncher.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/23.
//

import UIKit
import AVFoundation

class VideoLauncher: NSObject {
    static var player: AVPlayer? = nil
    static var playerLayer: AVPlayerLayer? = nil
    static var currentPlayindex: Int = 999
    static var isPlaying: Bool = true
    static var currentSecond: Float64 = 0
}
