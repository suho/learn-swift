//: Playground - noun: a place where people can play

import UIKit

//Tao Mang 2 Chieu
func declareTwoDimensionalArray(cols: Int, rows: Int) -> Array<Array<Int>> {
    var result = Array<Array<Int>>()
    for _ in 0..<rows {
        result.append(Array(count: cols, repeatedValue: Int()))
    }
    
    for i in 0..<rows {
        for j in 0..<cols {
            result[i][j] = -Int(arc4random_uniform(100)) + 50
        }
    }
    return result
}

//Ma Tran Doi Xung Qua Duong Cheo
func isSymmetricMatrix(array: [[Int]]) -> Bool {
    var result = false
    for i in 0..<array.count {
        for j in 0..<array[i].count {
            if array[i][j] == array[j][i] {
                result = true
            } else {
                result = false
                return result
            }
        }
    }
    return result
}

let array = declareTwoDimensionalArray(3, rows: 3)
//isSymmetricMatrix([[1, 1, 1], [1, 1, 1], [1, 1 ,1]])

//Dem So Am, So Boi 5 Tren Duong Cheo Phu
func findNegativeNumberAndMultipleFive(array: [[Int]]) -> ([Int], [Int]) {
    var arrayNegativeNumber = [Int]()
    var arrayMultipleFive = [Int]()
    for i in 0..<array.count {
        for j in 0..<array[i].count {
            if (i + j == array.count - 1) {
                if array[i][j] < 0 {
                    arrayNegativeNumber.append(array[i][j])
                }
                if array[i][j] % 5 == 0 {
                    arrayMultipleFive.append(array[i][j])
                }
            }
        }
    }
    return (arrayNegativeNumber, arrayMultipleFive)
}

//findNegativeNumberAndMultipleFive(array)



//Sort Rows of Array
func sortArrayDecrease(array: Array<Int>) -> [Int] {
    var arrayDecrease = array
    arrayDecrease.sortInPlace({value1, value2 in value1 > value2})
    return arrayDecrease
}

func sortTwoDimensionalArray(array: [[Int]]) -> [[Int]] {
    var result = array
    for i in 0..<result.count {
        result[i] = sortArrayDecrease(result[i])
    }
    return result
}

sortTwoDimensionalArray(array)



