//: Playground - noun: a place where people can play

import UIKit

func totalExpression(x: Float, n: Int) -> Double {
    var total: Double = 0
    let valueX = Double(x)
    if n > 1 {
        for k in 1...n {
            let valueK = Double(k)
            if k % 2 == 0 {
                total += -pow(valueX, valueK)/valueK
            } else {
                total += pow(valueX, valueK)/valueK
            }
        }
        return total
    } else {
        return 0
    }
}

//totalExpression(2, n: 3)

func fibonacci(number: Int) -> Int {
    if number <= 1 {
        return number
    } else {
        let fibNum = fibonacci(number - 1) + fibonacci(number - 2)
        return fibNum
    }
}

//fibonacci(1)
//fibonacci(2)
//fibonacci(3)
//fibonacci(4)
//fibonacci(5)
