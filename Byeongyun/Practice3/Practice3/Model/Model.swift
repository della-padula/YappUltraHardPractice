//
//  Model.swift
//  Practice3
//
//  Created by ITlearning on 2021/10/03.
//

import UIKit

protocol ModelProtocol {
}

class Model: ModelProtocol {
    let images: [UIImage?] = [UIImage(named: "app01"), UIImage(named: "app02"), UIImage(named: "app03"), UIImage(named: "app04"), UIImage(named: "app05") ]
    let mainTitles: [String] = ["BMW R 18에 올라타!", "iPhone 필수 앱", "이번주 인기 앱", "오늘의 앱", "취향에 맞는 앱"]
    let subTitles: [String] = [ "SPECIAL EVENT", "필수적으로 다운 받아야하는 앱들!", "고르고 골랐어요.", "오늘의 앱은 무엇일까요?", "당신의 취향을 고려하여 골라봤어요." ]
}
