//: Playground - noun: a place where people can play

import UIKit

func declareTwoDimensionalArray(cols: Int, rows: Int) -> Array<Array<Int>> {
    var result = Array<Array<Int>>()
    for _ in 0..<rows {
        result.append(Array(count: cols, repeatedValue: Int()))
    }
    return result
}

func spiralArray(array: [[Int]]) -> [[Int]] {
    var result = array
    var index = 1
    
    var leftUp = 0
    var rightUp = 0
    var leftBottom = result.count - 1
    var rightBottom = result.count - 1
    
    var value = 1
    
    while index < (result.count * result.count) {
        for i in leftUp...rightBottom {
            result[rightUp][i] = value
            value += 1
            index += 1
        }
        rightUp += 1
        for i in rightUp...leftBottom {
            result[i][rightBottom] = value
            value += 1
            index += 1
        }
        rightBottom -= 1
        for i in (leftUp...rightBottom).reverse() {
            result[leftBottom][i] = value
            value += 1
            index += 1
        }
        leftBottom -= 1
        for i in (rightUp...leftBottom).reverse() {
            result[i][leftUp] = value
            value += 1
            index += 1
        }
        leftUp += 1
        result
    }
    return result
}

spiralArray(declareTwoDimensionalArray(5, rows: 5))






