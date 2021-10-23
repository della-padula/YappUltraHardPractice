//
//  Model.swift
//  Practice4
//
//  Created by ITlearning on 2021/10/07.
//

import UIKit

protocol ModelProtocol {
    func lyricParse()
}

class Model: ModelProtocol {
    
    let lyrics = """
    [00:14.38]저녁 노을을 바라보며
    [00:18.07]널 만나 다행이라고 하던 날이
    [00:22.20]벌써
    [00:23.95]꽤나 오래 전 이야기야
    [00:27.51]이제는
    [00:28.77]노을은 밤의 시작일 뿐이야
    [00:32.89]모든 게 아름다웠어
    [00:34.96]우울한 날들은 없었어
    [00:37.20]지금 돌이켜보면
    [00:39.45]우습기도 하지만
    [00:41.83]후회는 남기지 않았어
    [00:44.26]사랑했으니까 뭐 됐어
    [00:46.60]Oh~
    [00:47.39]첫째 날부터
    [00:49.08]마지막 날까지
    [00:51.46]아
    [00:52.46]행복했던 날들이었다
    [00:57.94]꿈만 같았었지
    [01:00.83]이제 더는 없겠지만
    [01:07.02]지난 날로 남겨야지
    [01:11.27]. . .
    [01:19.69]말하다 생기는 정적은
    [01:23.46]전엔 아무렇지 않았는데 이젠
    [01:27.61]달라
    [01:28.96]너무도 길게 느껴지고
    [01:32.82]가슴이
    [01:34.30]쓰리고 답답해서 힘들어
    [01:37.90]매 순간이 아까웠어
    [01:40.09]가는 시간이 참 미웠어
    [01:42.46]지금 돌이켜 보면
    [01:44.64]바보 같긴 하지만
    [01:47.15]후회는 남기지 않았어
    [01:49.39]사랑했으니까 뭐 됐어
    [01:51.93]Oh~
    [01:52.58]첫째 날부터
    [01:54.39]마지막 날까지
    [01:56.83]아
    [01:57.90]행복했던 날들이었다
    [02:03.07]꿈만 같았었지
    [02:06.08]이제 더는 없겠지만
    [02:12.33]지난 날로 남겨야지
    [02:15.82]. . .
    [02:24.85]아주 가끔은
    [02:26.98]그리워할 거야 널
    [02:29.85]사실 가끔은
    [02:31.60]아니고 자주겠지
    [02:34.26]아주 가끔은
    [02:36.25]눈물이 흐를 거야
    [02:38.92]그 때도 괜찮다고
    [02:41.05]되뇌일 거야
    [02:45.78]아
    [02:46.83]행복했던 날들이었다
    [02:52.05]꿈만 같았었지
    [02:54.92]이제 더는 없겠지만
    [03:00.67]지난 날로 남겨야지
    """
    
    var lyricDic: Dictionary<Double, String> = [:]
    var lyricArray: Array<String> = []
    var lyricTimeArray: Array<Double> = []
    let background = UIImage(named: "background")
    let albumCover = UIImage(named: "Day6")
    let song = NSDataAsset(name: "song")
    
    func lyricParse() {
        let lines = lyrics
            .replacingOccurrences(of: "\\n", with: "\n")
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
        let cLine = lines
        for i in cLine {
            if i.hasPrefix("[") {
                guard let closureIndex = i.range(of: "]")?.lowerBound else { break }
                
                let startIndex = i.index(i.startIndex, offsetBy: 1)
                let endIndex = i.index(closureIndex, offsetBy: 0)
                let amidString = String(i[startIndex..<endIndex])
                let lyricStartIndex = i.index(endIndex, offsetBy: 1)
                let lyricString = String(i[lyricStartIndex..<i.endIndex])
                let amidStrings = amidString.components(separatedBy: ":")
                guard let min = Double(amidStrings[0]) else { return }
                guard let sec = Double(amidStrings[1]) else { return }
                let minute: TimeInterval = min
                let second: TimeInterval = sec
                
                let time = String(format: "%.2f", minute * 60 + second)
                guard let stringToDouble = Double(time) else { return }
                lyricDic[stringToDouble] = lyricString
                lyricTimeArray.append(stringToDouble)
                lyricArray.append(lyricString)
            }
        }
    }
}
