//: Playground - noun: a place where people can play

import UIKit

//Bai 4: tinh a^n

func tinhBieuThuc(giaTriA a: Double, giaTriN n: Double) -> String {
    if a < 0 {
        return "Gia Tri a < 0"
    }
    return "Gia tri \(Int(a))^\(Int(n)) = \(Int(exp(n*log(a))))"
}

print("\(tinhBieuThuc(giaTriA: 2, giaTriN: 2))")

//Bai 5: find max of 4 value

func findMaximum(giaTriA a: Double, giaTriB b: Double, giaTriC c: Double, giaTriD d: Double) -> Double {
    var max = a;
    if b > max {
        max = b
    }
    if c > max {
        max = c
    }
    if d > max {
        max = d
    }
    return max
}

