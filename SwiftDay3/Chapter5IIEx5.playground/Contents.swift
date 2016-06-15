//: Playground - noun: a place where people can play

import UIKit

func declareTwoDimensionalArray(cols: Int, rows: Int) -> Array<Array<Int>>{
    var result = Array<Array<Int>>()
    for _ in 0..<rows {
        result.append(Array(count: cols, repeatedValue: Int()))
    }
    
    for i in 0..<rows {
        for j in 0..<cols {
            result[i][j] = Int(arc4random_uniform(10)+1)
        }
    }
    return result
}

func diagonalMatrix(array: Array<Array<Int>>) -> Array<Array<Int>> {
    var result = array
    for i in 0..<result.count {
        var max = result[i][0]
        var index = 0
        for j in 1..<result.count {
            if result[i][j] > max {
                max = result[i][j]
                index = j
            }
        }
        result[i][index] = result[i][result.count/2]
        result[i][result.count/2] = max
    }
    return result
}

let array = declareTwoDimensionalArray(3, rows: 3)

//diagonalMatrix(array)

func minInRowToLast(array: Array<Array<Int>>) -> Array<Array<Int>> {
    var result = array
    for i in 0..<result.count {
        var min = result[i][0]
        var index = 0
        for j in 1..<result.count {
            if result[i][j] < min {
                min = result[i][j]
                index = j
            }
        }
        result[i][index] = result[i][result.count - 1]
        result[i][result.count - 1] = min
    }
    return result
}

minInRowToLast(array)
