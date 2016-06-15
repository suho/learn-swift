//: Playground - noun: a place where people can play

import UIKit

func sumAndMulti(array: Array<Int>) -> (Int, Int) {
    var sum = 0
    var multi = 1
    for item in array {
        if item > 0 {
            sum += item
            multi *= item
        }
    }
    return (sum, multi)
}

//sumAndMulti([1, 3, 0, -2, -1, 10, -5])

func testTwoDimensionalArray() {
    let numColumns = 5
    let numRows = 10
    var array = Array<Array<Int>>()
    for _ in 0..<numRows {
        array.append(Array(count: numColumns, repeatedValue: Int()))
    }
    for i in 0..<numRows {
        for j in 0..<numColumns {
            array[i][j] = Int(arc4random_uniform(10)+1)
        }
    }
    array
}

//testTwoDimensionalArray()








