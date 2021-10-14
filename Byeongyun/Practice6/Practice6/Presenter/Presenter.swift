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
    func arrayMove(_ index: Int)
    func fetch(completion: @escaping (Array<CGFloat>) -> Void)
    func selectFilter(_ select: Int)
    func showPick() -> Int
    func showPickerArray() -> [String]
    func fetchMonthData(_ index: Int, completion: @escaping ([CGFloat]) -> Void)
}

class Presenter: ViewControllerProtocol {
    private let urlArray = [ "https://api.github.com/search/commits?q=author:ITlearning+committer-date:2021-10-01..2021-10-30",
        "https://api.github.com/search/commits?q=committer-email:yo7504@kakao.com+committer-date:2021-10-01..2021-10-30",
        "https://api.github.com/search/commits?q=committer-email:yo7504@naver.com+committer-date:2021-10-01..2021-10-30"
    ]
    private let urlOriginal = "https://api.github.com/search/commits?q=author:ITlearning+committer-date:"
    private let ar = [["2021-10-01..2021-10-15"], ["2021-05-01..2021-05-31","2021-06-01..2021-06-30", "2021-07-01..2021-07-30", "2021-08-01..2021-08-31", "2021-09-01..2021-09-30", "2021-10-01..2021-10-31"], ["2019", "2020", "2021"] ]
    private var dayCounter = [CGFloat](repeating: 0, count: 31)
    private var data: [Item] = []
    private var count: [CGFloat] = []
    private var array: [String] = []
    private let pickerArray: [String] = ["일별", "월별", "연별"]
    private var selectIndex: Int = 0
    func arrayMove(_ index: Int) {
        fetchData() { arr in
            self.array = arr
        }
    }

    func selectFilter(_ select: Int) {
        selectIndex = select

    }

    func showPick() -> Int {
        selectIndex
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


    func fetchMonthData(_ index: Int, completion: @escaping ([CGFloat]) -> Void) {
        count = []
        for url in self.ar[index] {
            let tmpURL = urlOriginal+url
            AF.request(tmpURL).responseJSON { (response) in
                switch response.result {
                case .success(let res):
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: res, options: .fragmentsAllowed)
                        let getInstanceData = try JSONDecoder().decode(CommitModel.self, from: dataJSON)
                        var num = Int()
                        num = getInstanceData.total_count
                        self.count.append(CGFloat(num))
                        //print("달별", self.count )
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
                completion(self.count)
            }
        }

    }
}
