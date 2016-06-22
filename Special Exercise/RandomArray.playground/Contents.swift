//: Playground - noun: a place where people can play

import UIKit

//Tao Mang Tang Dan
func createArray(maxElementOfArray: Int) -> [Int] {
    var increaseArray = [Int]()
    for i in 1...maxElementOfArray {
        increaseArray.append(i)
    }
    return increaseArray
}

let increaseArray = createArray(10)


//Random Phan Tu
func randomArray(increaseArray: [Int]) -> [Int] {
    var array = increaseArray
    var result = [Int]()
    
    let countOfArrayIncrease = increaseArray.count
    
    for _ in 0..<countOfArrayIncrease {
        
        let countOfArray = array.count
        let indexRandom = Int(arc4random_uniform(UInt32(countOfArray)))
        result.append(array[indexRandom])
        array.removeAtIndex(indexRandom)
        
    }
    return result
}

randomArray(increaseArray)

//Solution 2

func randomArray2(increaseArray: [Int]) -> [Int] {
    var array = increaseArray
    for index in 0..<(array.count/2) {
        let indexRandom = Int(arc4random_uniform(UInt32(array.count)))
        let value = array[indexRandom]
        array[indexRandom] = array[index]
        array[index] = value
    }
    return array
}


randomArray2(increaseArray)

//Extension random for Array

extension Array {
    func random() -> Array {
        var array = self
        for index in 0..<(array.count/2) {
            let indexRandom = Int(arc4random_uniform(UInt32(array.count)))
            let value = array[indexRandom]
            array[indexRandom] = array[index]
            array[index] = value
        }
        return array
    }
}


increaseArray.random()

["a", "b", "c", "d", "e"].random()








