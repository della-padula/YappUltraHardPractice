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
        VideoContent(videoImage: "image10", channelImage: "channelLogo05", videoMainLabel: "손흥민: \"방금 제가 찬 프리킥 꼭 올려주세요\"", profileLabel: "사이삼일 4231·조회수 1.8만회·2일전", videoUrl: "https://drive.google.com/uc?export=open&id=1bmuO4UFg_k5QHt4hUHGN-HqfaZCZ4GUO", channelInfo: "구독자 5만명", channelName: "사이삼일 4231"),
        VideoContent(videoImage: "image11", channelImage: "channelLogo06", videoMainLabel: "[#도깨비] 900년 산 도깨비 잡는 은탁이의 다발총 질투ㅋㅋ", profileLabel: "tvN D ENT·조회수 288만회·1년전", videoUrl: "https://drive.google.com/uc?export=open&id=1QxVCIao8NC-S-UJYSSe1NQHZmqqh7SBK", channelInfo: "구독자 305만명", channelName: "tvN D ENT"),
        VideoContent(videoImage: "image12", channelImage: "channelLogo07", videoMainLabel: "Cover by 신용재 SHIN YONG JAE - 희재 (성시경)", profileLabel: "신용재·조회수 98만회·1년전", videoUrl: "https://drive.google.com/uc?export=open&id=1YYOgCESXcpx4Udv-BdGFAK4kImBzoHWd", channelInfo: "구독자 13만명", channelName: "신용재"),
        VideoContent(videoImage: "image13", channelImage: "channelLogo03", videoMainLabel: "[MV] LOONA(이달의 소녀) _ PTT (Paint The Town)", profileLabel: "1theK (원더케이)·조회수 295만회·4개월 전", videoUrl: "https://drive.google.com/uc?export=open&id=17O3s9ozjKFVF8KdtOm87ll-wVQMnVE_4", channelInfo: "구독자 124만명", channelName: "1theK (원더케이)")
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
