//
//  Month.swift
//  Practice6
//
//  Created by ITlearning on 2021/10/14.
//

import Foundation

struct Month {
    let january = 31
    var febuary: Int {
        let current_date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let current_data_string = formatter.string(from: current_date)

        if Int(current_data_string)!%400 == 0 {
            return 29
        } else if Int(current_data_string)!%100 != 0 && Int(current_data_string)!%4 == 0 {
            return 29
        } else {
            return 28
        }
    }

    func setNumber() -> Int{
        let current_date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let m = Int(formatter.string(from: current_date))!
        if m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12 {
            return 31
        } else if m == 2 {
            return febuary
        } else {
            return 30
        }
    }

}
