//: Playground - noun: a place where people can play

import UIKit

func oddAndDivFiveFirst(array: Array<Int>) -> Array<Int> {
    var changeArray = array
    var index = 0
    for i in 0..<changeArray.count {
        if (changeArray[i] % 5 == 0) || (changeArray[i] % 2 == 1) {
            let temp = changeArray[i]
            changeArray[i] = changeArray[index]
            changeArray[index] = temp
            index += 1
        }
    }
    return changeArray
}

//oddAndDivFiveFirst([1, 4, 5, 0, 3, 4, 6, 5, 10])

func converseArray(array: Array<Int>) -> Array<Int> {
    var converseA = array
    for i in 0..<converseA.count/2 {
        let temp = converseA[i]
        converseA[i] = converseA[converseA.count - i - 1]
        converseA[converseA.count - i - 1] = temp
    }
    return converseA
}

converseArray([1, 2, 3, 4, 5, 6, 7, 8, 9])
