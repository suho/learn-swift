//: Playground - noun: a place where people can play

import UIKit

//Copy Array A, B To C

func copyArray(arrayA: Array<Int>, arrayB: Array<Int>) -> Array<Int> {
    let count = arrayA.count + arrayB.count
    var arrayResult = Array<Int>()
    
    var even = 0
    var odd = 0

    for i in 0..<count {
        if i > 2*arrayA.count {
            arrayResult.append(arrayB[odd])
            odd += 1
        } else if i > 2*arrayB.count {
            arrayResult.append(arrayA[even])
            even += 1
        } else {
            if i % 2 == 0 {
                arrayResult.append(arrayA[even])
                even += 1
            } else {
                arrayResult.append(arrayB[odd])
                odd += 1
            }
        }
    }
    
    return arrayResult
}


copyArray([1, 3, 5, 7, 9], arrayB: [2, 4, 6, 8])