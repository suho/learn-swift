//: Playground - noun: a place where people can play

import UIKit

//find Kaprekar Number

func splitNumber(number: Int) -> Array<Int> {
    var splitArray = Array<Int>()
    var value = number
    while value != 0 {
        splitArray.append(value % 10)
        value = value / 10
    }
    return splitArray
}

func sortArrayIncrease(array: Array<Int>) -> Int {
    var arrayIncrease = array
    arrayIncrease.sortInPlace({value1, value2 in value1 < value2})
    return arrayToNumber(arrayIncrease)
}

func sortArrayDecrease(array: Array<Int>) -> Int {
    var arrayDecrease = array
    arrayDecrease.sortInPlace({value1, value2 in value1 > value2})
    return arrayToNumber(arrayDecrease)
}

func arrayToNumber(array: Array<Int>) -> Int {
    var number = 0
    
    for i in 0..<array.count {
        number = number*10 + array[i]
    }
    return number
}

func checkKapreNumber(number: Int) -> Bool {
    let arraySplit = splitNumber(number)
    let increaseNumber = sortArrayIncrease(arraySplit)
    let decreaseNumber = sortArrayDecrease(arraySplit)
    if number == increaseNumber + decreaseNumber {
        return true
    } else {
        return false
    }
}

func findKaprekarNumber(value: Int) -> Array<Int> {
    var arrayKapreNumber = Array<Int>()
    for i in 1..<value {
        if checkKapreNumber(i) {
            arrayKapreNumber.append(i)
        }
    }
    return arrayKapreNumber
}













