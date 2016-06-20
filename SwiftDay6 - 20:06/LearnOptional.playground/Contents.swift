//: Playground - noun: a place where people can play

import UIKit

var errorCode: Int?
errorCode = 100
errorCode = nil

var myFavoriteSong: String?
myFavoriteSong = "Beautiful Girl"

let ageInteger: Int? = 22
//print(ageInteger)

//print(ageInteger! + 1)

let nameString: String?
//print(nameString!)

nameString = nil

if let name = nameString {
    print(name)
} else {
    print("No Name")
}

if let name = nameString, age = ageInteger {
    print("\(name): \(age)")
} else {
    print("No Name or No Age")
}


let name = nameString ?? "SuHV" //"SuHV" if nameString == nil

var myName: String? = "Ray"
//var myAge: Int = nil
let distance: Float = 26.7
var middleName: String? = nil


func divide(numberA: Int, numberB: Int) -> Int? {
    if numberA % numberB == 0 {
        return numberA / numberB
    } else {
        return nil
    }
}

if let result = divide(10, numberB: 2) {
    print("Yep, It divides \(result) times")
} else {
    print("Not dividible :[")
}

let result = divide(10, numberB: 3) ?? 0
print("Yep, It divides \(result) times")










