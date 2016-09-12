//: Playground - noun: a place where people can play

import UIKit

var ageInt : Int?
let valueCheck = 1
if valueCheck == 1 {
    ageInt = 10
} else {
    ageInt = nil
}

if ageInt != nil {
    print(ageInt! + 1)
}

var name: String? = "Ray"
//var age: Int = nil
let distance: Float = 26.7
var middleName: String? = nil


func divideIfWhole(value: Int, by divisor: Int) -> Int? {
    if value % divisor == 0 {
        return value / divisor
    } else {
        return nil
    }
}

if let answer = divideIfWhole(10, by: 3) {
    print("Yep, it divides \(answer) times.")
} else {
    print("Not divisible :[.")
}


let answer1 = divideIfWhole(10, by: 3) ?? 0
print("It divides \(answer1) times.")

let answer2 = divideIfWhole(10, by: 3) ?? 0
print("It divides \(answer2) times.")