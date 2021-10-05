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
            MainUnit(title: "iPad가 처음이라면",
                     subTitle: "고르고 골랐어요",
                     emoji: "📱",
                     backgroundColor: .systemBlue,
                     detailUnits: [
                        DetailUnit(title: "첫 iPad를 구입한 당신.",
                                   subTitle: "무한한 가능성을 손에 쥐고 있군요.",
                                   emoji: "📱",
                                   paragraph: """
   창의성을 발휘할 준비가 되었나요? 마음껏 그리고, 편집하고, 작곡하고, 써내려가보세요.

   업무에 활용할 계획인가요? 더 쉽게 일정을 관리하고 깔끔하게 문서와 프레젠테이션을 작성하세요.

   App Store 에디터가 선정한 가장 강력한 iPad 앱들과 함께 시작해봅시다.
   """),
                        DetailUnit(title: "첫 iPad를 구입한 당신.",
                                   subTitle: "",
                                   emoji: "👏",
                                   paragraph: """
창의성을 발휘할 준비가 되었나요? 마음껏 그리고, 편집하고, 작곡하고, 써내려가보세요.
업무에 활용할 계획인가요? 더 쉽게 일정을 관리하고 깔끔하게 문서와 프레젠테이션을 작성하세요.
App Store 에디터가 선정한 가장 강력한 iPad 앱들과 함께 시작해봅시다.
"""),
                        DetailUnit(title: "스케치와 디자인",
                                   subTitle: "",
                                   emoji: "✏️",
                                   paragraph: "iPad와 Apple Pencil, 그리고 이 앱들과 함께라면 표현하지 못할 선과 색은 없습니다. 마음이 시키는 대로, 거침 없이 그려보고 칠해보세요."),
                        DetailUnit(title: "이미지 편집",
                                   subTitle: "",
                                   emoji: "🌃",
                                   paragraph: "RAW 포맷 지원과 초고해상도 이미지 편집도 거뜬히 해내는 것은 기본. 강력한 AI를 활용해 동영상과 사진 보정에 날개를 달아주는 앱들이 있습니다. 데스크탑 수준의 전문적인 작업을 경험해보세요.")
                     ])
        ]
    }
}
