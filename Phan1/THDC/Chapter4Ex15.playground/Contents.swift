//: Playground - noun: a place where people can play

import UIKit

func divisorAndMultiple(a: Int, b: Int) -> (Int, Int) {
    
    var valueA = abs(a)
    var valueB = abs(b)
    var divisor = 1
    var multiple = 1
    
    while (valueA != 0 && valueB != 0) {
        if valueA > valueB {
            valueA = valueA - valueB
        } else {
            valueB = valueB - valueA
        }
        
        if valueA == 0 {
            divisor = valueB
        } else {
            divisor = valueA
        }
    }
    
    multiple = (a * b)/divisor
    
    return (divisor, multiple)
}


//divisorAndMultiple(6, b: 8)



//Check Prime Number

func isPrimeNumber(a: Int) -> Bool {
    var count = 0
    for i in 2...a/2 {
        if a % i == 0 {
            count += 1
        }
    }
    if count == 0 {
        return true
    } else {
        return false
    }
}

//isPrimeNumber(83)
