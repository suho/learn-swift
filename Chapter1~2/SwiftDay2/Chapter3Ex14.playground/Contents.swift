//: Playground - noun: a place where people can play

import UIKit

func totalAndMulti(value: Int) -> (Int, Int) {
    var total = 0
    var multi = 1
    var changeValue = value
    repeat {
        total += changeValue % 10
        multi *= changeValue % 10
        changeValue = changeValue/10
    } while (changeValue != 0)
    
    return (total, multi)
}

//totalAndMulti(112345)

func printPrimeNumber(value: Int) -> Array<Int> {
    var primeNumber = [2]
    if value < 2 {
        return [0]
    } else {
        for i in 2..<value {
            for j in 2..<i+1 {
                if (i % j == 0) {
                    break
                } else {
                    if j == i-1 {
                        primeNumber.append(i)
                    }
                }
            }
        }
        return primeNumber

    }
}

//printPrimeNumber(1)