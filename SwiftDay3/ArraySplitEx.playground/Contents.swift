//: Playground - noun: a place where people can play

import UIKit

func splitArray(array: [Int], index: Int, index2: Int) -> [Int] {
    var result = [Int]()
    for i in 0..<array.count {
        if i >= index && i <= index2 {
            result.append(array[i])
        }
    }
    return result
}

func getArray() -> [Int] {
    var result = [Int]()
    for i in 1...100 {
        result.append(i)
    }
    return result
}

var array = getArray()

splitArray(array, index: 10, index2: 20)