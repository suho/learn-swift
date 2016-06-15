//: Playground - noun: a place where people can play

import UIKit

func bangCuuChuong() {
    for i in 1...9 {
        print("------------")
        for j in 1...10 {
            print("\(i) x \(j) = \(i*j)")
        }
    }
}

//bangCuuChuong()

func buffalo() -> Array<(Int, Int, Int)>{
    var countBuffalo = [(Int, Int, Int)]()
    for stand in 0...20 {
        for recumbent in 0...33 {
            for old in 0...300 {
                if (stand + recumbent + old == 100) && (old + 9*recumbent + 15*stand == 300) {
                    countBuffalo.append((stand, recumbent, old))
                }
            }
        }
    }
    return countBuffalo
}

//for (stand, recumbent, old) in buffalo() {
//    print("\(stand), \(recumbent), \(old)")
//}

func printNumber() {
    for i in 0...99 {
        if i % 10 != 9 {
            print(i, terminator: " ")
        } else {
            print(i)
        }
    }
}

//printNumber()


func printChessBoard() {
    for row in 0..<8 {
        for column in 0..<8 {
            print(row*column, terminator: " ")
        }
        print("")
    }
}

//printChessBoard()

func printRowEven() {
    for row in 0..<8 {
        if row % 2 == 0 {
            print("")
            continue
        }
        for column in 0..<8 {
            print(row*column, terminator: " ")
        }
        print("")
    }
}

//printRowEven()

func printHalfBoard() {
    for row in 0..<8 {
        for col in 0..<8 {
            if row == col {
                break
            }
            print(row*col, terminator: " ")
        }
        print("")
    }
}

//printHalfBoard()


