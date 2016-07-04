//: Playground - noun: a place where people can play

import UIKit


//Find Perfect Number
func perfectNumber(n: Int) -> Set<Int> {
    var perNum = Set<Int>()
    for value in 1...n {
        var total = 0
        for divisor in 1..<value {
            if value % divisor == 0 {
                total = total + divisor
            }
        }
        if value == total {
            perNum.insert(value)
        }
    }
    return perNum
}

var n = Int(arc4random_uniform(1000) + 1)

print(perfectNumber(n))

