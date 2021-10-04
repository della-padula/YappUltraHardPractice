//
//  MainPresenter.swift
//  Practice3
//
//  Created by leeesangheee on 2021/10/04.
//

import UIKit

protocol MainView: AnyObject {
    func setHeader()
}

protocol MainViewPresenter {
    func getMainUnits()
}

class MainPresenter: MainViewPresenter {
    var mainUnits: [MainUnit] = []
    var currentDateString: String = ""
    
    init() {
        getMainUnits()
        getDateString()
    }
    
    func getDateString() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM월 dd일 "
        let dateString = formatter.string(from: Date())

        formatter.dateFormat = "e"
        let day = formatter.string(from: Date())
        var dayString = ""
        
        switch day {
        case "1": dayString = "일요일"
        case "2": dayString =  "월요일"
        case "3": dayString =  "화요일"
        case "4": dayString =  "수요일"
        case "5": dayString =  "목요일"
        case "6": dayString =  "금요일"
        case "7": dayString =  "토요일"
        default: dayString =  "일요일"
        }
        
        currentDateString = dateString + dayString
    }
    
    func getMainUnits() {
        mainUnits = [
            MainUnit(title: "오늘의 앱",
                     subTitle: "사진 찍기",
                     emoji: "📷",
                     backgroundColor: .systemBlue,
                     paragraph: """
일상 속에서도 우린 멋진 사진을 찍고 싶습니다.

카메라나 사진에 대해 잘 몰라도, 내 일상이 소셜 미디어 너머 누군가의 삶처럼 화려하지 않아도 말이죠.

그럴 땐 <@picn2k>를 열어 보세요. 평범한 하루라도 아름답게 담을 수 있답니다.
"""),
            MainUnit(title: "Apple Watch와 뛰어요",
                     subTitle: "건강한 삶",
                     emoji: "🏃‍♀️",
                     backgroundColor: .systemOrange,
                     paragraph: """
러닝에 온전히 집중하고 싶은 당신.

Apple Watch를 통해 모든 걸 해결할 수 있습니다. 바깥 날씨와 미세 먼지 농도도, 달릴 때 속도와 거리, 러닝 시간도 손목 위에서 바로 확인할 수 있거든요. 앱에 맡겨두고 오직 달리는 거에만 몰입해보세요.
"""),
            MainUnit(title: "세계에서 가장 달콤한 왕국",
                     subTitle: "지금 경험하세요",
                     emoji: "🍪",
                     backgroundColor: .brown,
                     paragraph: """
어디서 달콤한 냄새 안 나요?

국민 러닝 게임, '쿠키런'이 잠시 달리기는 내려놓고 왕국을 건설하는 전략 RPG 장르로 새롭게 찾아왔습니다. 용감한 쿠키와 친구들이 드디어 마녀의 손아귀를 벗어나 <쿠키런: 킹덤>이라는 새로운 삶의 터전을 찾았죠. 최근 치열한 길드 기능이 추가된 이 왕국이 어떤 곳인지 살펴볼까요?
"""),
            MainUnit(title: "추억 속으로",
                     subTitle: "지금 경험하세요",
                     emoji: "🎮",
                     backgroundColor: .systemGray,
                     paragraph: """
어릴 적 즐기던 바로 그 게임!

마리오와 달리고, 레이맨이 되어 환상적인 모험을 즐기고, 소닉과 쌩쌩 달리던 추억속으로 다시 들어가보세요. 시간이 흐른 지금, 사뭇 다른 기분이 들지도 몰라요.
"""),
            MainUnit(title: "악기 하나쯤 배웁시다",
                     subTitle: "시작하기",
                     emoji: "🎸",
                     backgroundColor: .systemPurple,
                     paragraph: """
골라보세요. 기타인가요? 피아노인가요?

적막한 일상에 멜로디를 더하고 싶을 때. 친구들 사이에서 "나 악기 다룰 줄 아는 사람이야"라며 으스대고 싶을 때. 맛집 탐방 말고 다른 취미 좀 갖고 싶을 때. 연인에게 선물할 필살기 한 방이 필요할 때.

둘 중 더 끌리는 걸 골라 배워보세요. 기타인가요? 피아노인가요?
"""),
            MainUnit(title: "여기가 화성이라고?",
                     subTitle: "추천 게임",
                     emoji: "🪐",
                     backgroundColor: .systemIndigo,
                     paragraph: """
화성으로 떠나 봅시다.

우주 탐험가가 되어서 말이죠. 꿈같은 이야기지만 <Mars: Mars>에서라면 가능합니다.

우리의 임무는? 한 정거장에서 다음 정거장까지 안전하게 이동하며 화성을 탐사하는 겁니다. 하지만 그게 만만치가 않죠. 양쪽 어깨에 멘 제트팩을 잘 활용해야 합니다. 몸이 붕 뜬 상태에서 좌우로 방향을 조절하며 안전하게 착지해야 하죠. 연료가 금세 바닥나니 조금만 우물쭈물해도 훅 고꾸라지고 말 거에요. 너무 빠르게 착륙해도 충격을 못 이기고 펑 폭발해 버릴 거고요.
""")
        ]
    }
}
