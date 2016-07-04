//: Playground - noun: a place where people can play

import UIKit

func piNumber(n: Int) -> Double {
    let e: Double = 0.0001
    var a: Double = 1
    var b: Double = 1
    var index: Int = 0
    var n: Double = 3
    while fabs(b) > e {
        b = -b*(n-2)/n
        a = a + b
        n = n + 2
        index += 1
    }
    return a*4
}

//piNumber(3)

func printFibonacci(n: Int) -> String{
    var result = "1 1"
    var fib1 = 1
    var fib2 = 1
    while fib1 + fib2 < n {
        let fib = fib1 + fib2
        result += " \(fib)"
        fib2 = fib1
        fib1 = fib
    }
    return result
}

//printFibonacci(100)