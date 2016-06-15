//: Playground - noun: a place where people can play

import UIKit

func recursive(valueN: Int, valueA: Double) -> Double {
    var total: Double = 1
    if valueN == 0 {
        return 1
    } else {
        var t: Double = 1
        for _ in 1...valueN {
            t = t*valueA
            total = 1/t + recursive(valueN-1, valueA: valueA)
        }
        return total
    }
}

recursive(2, valueA: 2)


