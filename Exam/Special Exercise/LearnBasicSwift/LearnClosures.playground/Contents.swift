//: Playground - noun: a place where people can play

import UIKit

var multiplyClosure: (Int, Int) -> Int

/*multiplyClosure = {
    (a: Int, b: Int) -> Int in
    return a * b
}*/

/*multiplyClosure = {
    (a: Int, b: Int) in
    return a * b
}*/

multiplyClosure = { (a, b) in
    return a * b
}

/*multiplyClosure = {
    $0 * $1
}*/

func operateOnNumber(a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

let addClosure = {
    (a: Int, b: Int) in
    a + b
}

operateOnNumber(4, 2, operation: addClosure)

func addFunction(a: Int, _ b: Int) -> Int {
    return a + b
}

operateOnNumber(4, 2, operation: addFunction)

operateOnNumber(4, 2, operation: { (a: Int, b: Int) in
    return a * b
})

let voidClosure: () -> Void = {
    print("Learn Closure")
}

voidClosure()

var count = 1
let incrementCounter = {
    count += 1
}

incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()

print(count)

func countingClosure() -> (() -> Int) {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}


let counter1 = countingClosure()
let counter2 = countingClosure()

counter1()
counter2()
counter1()
counter1()
counter2()

func repeatTask(times: Int, task: () -> Void) {
    for _ in 0..<times {
        task()
    }
}

repeatTask(10, task: {
    print("Swift Apprentice is a great book!")
})


func mathSum(times: Int, operation: (Int) -> (Int)) -> Int {
    var result = 1
    for i in 1...times {
        result += operation(i)
    }
    return result
}

mathSum(10, operation: { number in
    return number * number
})




