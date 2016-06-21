//: Playground - noun: a place where people can play

import UIKit

var players = ["Bob", "Dan", "Alice", "Cindy"]

players.isEmpty

players.count

players.first

players.last

players.minElement()

players.maxElement()

players[2]

players[0]

players[1...2]

players.contains("Dan")

players.contains("Playground")

players.append("Eli")

players += ["Gina"]

players.insert("Frank", atIndex: 5)

players.removeLast()

players.removeAtIndex(2)

players

players[0...1] = ["Donna", "Craig", "Brian", "Anna"]

players

players.sort()

for playerName in players {
    print(playerName)
}

for (index, playerName) in players.enumerate() {
    print("\(index + 1). \(playerName)")
}

let scores = [2, 2, 8, 6, 4]

scores.reduce(0, combine: +)

scores.reduce(0, combine: -)

scores.reduce(1, combine: *)

print(scores.filter({$0 > 5}))

print(scores.map({$0 * 2}))


let array4 = [1, 2, 3]

func removeOnce(itemToRemove: Int, fromArray: [Int]) -> [Int] {
    var result = fromArray
    if let index = result.indexOf(itemToRemove) {
        result.removeAtIndex(index)
    }
    return result
}

removeOnce(200, fromArray: [100, 200, 300, 400])

func remove(itemToRemove: Int, fromArray: [Int]) -> [Int] {
    return fromArray.filter({$0 != itemToRemove})
}

remove(200, fromArray: [100, 200, 300, 400])


func reverse(array: [Int]) -> [Int] {
    var tempArray = array
    var result = [Int]()
    let n = tempArray.count
    for _ in 0..<n {
        result.append(tempArray.last!)
        tempArray.removeLast()
    }
    return result
}

reverse([1, 2, 3, 4, 5])