//
//  MainViewService.swift
//  Practice7
//
//  Created by ITlearning on 2021/10/20.
//

import Foundation

class MainViewService {
    private static let model = [
        VideoContent(videoImage: "image03", channelImage: "image04", videoMainLabel: "로이킴 (Roy Kim) - 살아가는 거야 (Linger On) MV", profileLabel: "Stone Music Entertainment·조회수 151만회·1년 전"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전")
    ]

    static func getVideoList() -> [VideoContent] {
        return model
    }
}
