//: Playground - noun: a place where people can play

import UIKit


var namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]

let emptyDictionary: [Int: Int]
emptyDictionary = [:]

print(namesAndScores["Brian"])

namesAndScores.count

namesAndScores.isEmpty

Array(namesAndScores.keys)

Array(namesAndScores.values)

namesAndScores.updateValue(10, forKey: "Donna")

namesAndScores

namesAndScores.removeValueForKey("Anna")

namesAndScores["Anna"]

for (key, value) in namesAndScores {
    print("\(key) - \(value)")
}

let namesString = namesAndScores.reduce("", combine: {$0 + "\($1), "})
print(namesString)

var dict5 = ["NY": "New York", "CA": "California"]
dict5["WA"] = "Washington"

dict5

var dictionary = ["NY": 1, "CA": 2]

func replaceValueForKey(key1: String, withValueForKey key2: String, inDictionary: [String: Int]) -> [String: Int] {
    var result = inDictionary
    let temp = result[key1]
    result[key1] = result[key2]
    result[key2] = temp
    return result
}

replaceValueForKey("NY", withValueForKey: "CA", inDictionary: dictionary)




