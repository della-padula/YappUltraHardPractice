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
        VideoContent(videoImage: "image03", channelImage: "channelLogo02", videoMainLabel: "로이킴 (Roy Kim) - 살아가는 거야 (Linger On) MV", profileLabel: "Stone Music Entertainment·조회수 151만회·1년 전", videoUrl: "https://drive.google.com/uc?export=open&id=1AxmS09PGigUu8wujA8WsAiVDxBPzCJP-", channelInfo: "구독자 124만명", channelName: "Stone Music Entertainment"),
        VideoContent(videoImage: "image08", channelImage: "channelLogo04", videoMainLabel: "t1 vs 담원 전설의 한타", profileLabel: "LOLplayer·조회수 65만회·3일전", videoUrl: "https://drive.google.com/uc?export=open&id=1rSX5puNs4WhZYtDK9IBpw8c4457A00DU", channelInfo: "구독자 124만명", channelName: "LOLplayer"),
        VideoContent(videoImage: "image07", channelImage: "channelLogo03", videoMainLabel: "[MV] Rothy(로시) _ COLD LOVE", profileLabel: "1theK (원더케이)·조회수 12만회·1주 전", videoUrl: "https://drive.google.com/uc?export=open&id=1Nka3e7bAagG8ivvcD0ILV9R_OwjY8dg1", channelInfo: "구독자 124만명", channelName: "1theK (원더케이)"),
        VideoContent(videoImage: "image09", channelImage: "channelLogo01", videoMainLabel: "디디가 사춘기가 왔나봐요!! 귀여워 미치겠네요ㅠㅠ", profileLabel: "크집사·조회수 20만회·2일전", videoUrl: "https://drive.google.com/uc?export=open&id=1qGKVhou_E_bsPDBw3JBjyf5GsYwGEIBA", channelInfo: "구독자 124만명", channelName: "크집사"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전", videoUrl: "", channelInfo: "구독자 124만명", channelName: "크집사"),
        VideoContent(videoImage: "image01", channelImage: "image02", videoMainLabel: "[키티빌런즈] 루루 끼이이아야야아오옹!!!", profileLabel: "크집사·조회수 25만회·3일전", videoUrl: "", channelInfo: "구독자 124만명", channelName: "크집사")
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
