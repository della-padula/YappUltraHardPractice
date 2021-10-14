//
//  Presenter.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/15.
//

import Foundation
import Alamofire

protocol ViewControllerProtocol {
    func fetchData(completion: @escaping (Array<String>) -> Void)
    func arrayMove(_ move: [String])
    func fetch(completion: @escaping (Array<CGFloat>) -> Void)
}

class Presenter: ViewControllerProtocol {
    let urlArray = [ "https://api.github.com/search/commits?q=author:ITlearning+committer-date:2021-10-01..2021-10-15",
        "https://api.github.com/search/commits?q=committer-email:yo7504@kakao.com+committer-date:2021-10-01..2021-10-15",
        "https://api.github.com/search/commits?q=committer-email:yo7504@naver.com+committer-date:2021-10-01..2021-10-15"
    ]
    private var dayCounter = [CGFloat](repeating: 0, count: 31)
    private var data: [Item] = []
    private var array: [String] = []
    private let pickerArray: [String] = ["연별", "월별", "일별"]
    private var selectPick = ""
    func arrayMove(_ move: [String]) {
        fetchData { arr in
            self.array = arr
        }
    }

    func selectFilter(_ select: String) {
        selectPick = select
    }

    func showPick() -> String {
        return selectPick
    }


    func showPickerArray() -> [String] {
        return pickerArray
    }
    
    func fetch(completion: @escaping (Array<CGFloat>) -> Void) {
        for i in array {
            let d = i.components(separatedBy: ["-","T"])
            guard let num = Int(d[2]) else { return }
            dayCounter[num-1] += 1
        }
        completion(dayCounter)
    }

    func fetchData(completion: @escaping (Array<String>) -> Void) {
        DispatchQueue.main.async {
            for url in self.urlArray {
                AF.request(url).responseJSON { (response) in
                    switch response.result {
                    case .success(let res):
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: res, options: .fragmentsAllowed)
                            let getInstanceData = try JSONDecoder().decode(CommitModel.self, from: dataJSON)
                            self.data = getInstanceData.items
                            print(self.data)
                            for i in self.data {
                                if !self.array.contains(i.commit.committer.date) {
                                    self.array.append(i.commit.committer.date)
                                } else {
                                    print(i.commit.committer.date)
                                }
                            }
                            self.array.sort()
                            self.arrayMove(self.array)
                            completion(self.array)
                        } catch(let err) {
                            print(err.localizedDescription)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }

            }
        }
    }

}
