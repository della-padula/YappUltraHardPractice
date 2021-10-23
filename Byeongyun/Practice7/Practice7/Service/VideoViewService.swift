//
//  MainViewService.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

class VideoViewService {
    private static var select = Int()
    private static let model = [
        VideoContent(videoImage: "image03", channelImage: "channelLogo02", videoMainLabel: "로이킴 (Roy Kim) - 살아가는 거야 (Linger On) MV", profileLabel: "Stone Music Entertainment·조회수 151만회·1년 전", videoUrl: "https://firebasestorage.googleapis.com/v0/b/writing-3f2f0.appspot.com/o/%E1%84%85%E1%85%A9%E1%84%8B%E1%85%B5%E1%84%8F%E1%85%B5%E1%86%B7(Roy%20Kim)%20-%20%E1%84%89%E1%85%A1%E1%86%AF%E1%84%8B%E1%85%A1%E1%84%80%E1%85%A1%E1%84%82%E1%85%B3%E1%86%AB%20%E1%84%80%E1%85%A5%E1%84%8B%E1%85%A3(Linger%20On)%20M-V.mp4?alt=media&token=05727f59-22c4-461f-bd62-4d95fc0c0a51"),
        VideoContent(videoImage: "image01", channelImage: "channelLogo01", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전", videoUrl: "https://firebasestorage.googleapis.com/v0/b/writing-3f2f0.appspot.com/o/%5B%E1%84%8F%E1%85%B5%E1%84%90%E1%85%B5%E1%84%87%E1%85%B5%E1%86%AF%E1%84%85%E1%85%A5%E1%86%AB%E1%84%8C%E1%85%B3%5D%20%E1%84%85%E1%85%AE%E1%84%85%E1%85%AE%20%E1%84%81%E1%85%B5%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%A1%E1%84%8B%E1%85%A3%E1%84%8B%E1%85%A3%E1%84%8B%E1%85%A1%E1%84%8B%E1%85%A9%E1%84%8B%E1%85%A9%E1%86%BC!!!%20(2).mp4?alt=media&token=3e95cf6f-9f4d-4846-8644-fb1496f2ab85"),
        VideoContent(videoImage: "image07", channelImage: "channelLogo03", videoMainLabel: "[MV] Rothy(로시) _ COLD LOVE", profileLabel: "1theK (원더케이)·조회수 12만회·1주 전", videoUrl: "https://firebasestorage.googleapis.com/v0/b/writing-3f2f0.appspot.com/o/%5BMV%5D%20Rothy(%E1%84%85%E1%85%A9%E1%84%89%E1%85%B5)%20_%20COLD%20LOVE.mp4?alt=media&token=cb07befe-fb4b-443e-a1c2-8aa53658f702"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전", videoUrl: ""),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전", videoUrl: ""),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전", videoUrl: "")
    ]

    static func getVideoIndex() -> Int {
        return select
    }

    static func setVideoIndex(_ index: Int) {
        self.select = index
    }

    static func getVideoList() -> [VideoContent] {
        return model
    }
}
