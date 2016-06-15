//: Playground - noun: a place where people can play

import UIKit

func isTrangle(a: Double, b: Double, c: Double) -> Bool {
    if (a > 0) && (b > 0) && (c > 0) && (a+b>c) && (a+c>b) && (b+c>a) {
        return true
    } else {
        return false
    }
}

func isIsoscelesTrangle(a: Double, b: Double, c: Double) -> Bool {
    if (a == b && a != c) || (b == c && a != c) || (c == a && a != b) {
        return true
    } else {
        return false
    }
}

func isEquilateralTrangle(a: Double, b: Double, c: Double) -> Bool {
    if a == b && a == c && b == c{
        return true
    } else {
        return false
    }
}

func isRightTrangle(a: Double, b: Double, c: Double) -> Bool {
    if (a*a + b*b == c*c) || (b*b + c*c == a*a) || (a*a + c*c == b*b) {
        return true
    } else {
        return false
    }
}

func isRightIsoscelesTrangle(a: Double, b: Double, c: Double) -> Bool {
    if (a*a + b*b == c*c && a == b) || (b*b + c*c == a*a && b == c) || (a*a + c*c == b*b && a == c) {
        return true
    } else {
        return false
    }
}

var a: Double = 3
var b: Double = 4
var c: Double = 5

if isTrangle(a, b: b, c: c) {
    if isRightIsoscelesTrangle(a, b: b, c: c) {
        print("This is A Right Isosceles Trangle!!")
    } else if isEquilateralTrangle(a, b: b, c: c) {
        print("This is A Equilateral Trangle!!")
    } else if isIsoscelesTrangle(a, b: b, c: c) {
        print("This is A Isosceles Trangle!!")
    } else if isRightTrangle(a, b: b, c: c) {
        print("This is A Right Trangle!!")
    } else {
        print("This is A Normal Trangle!!")
    }
} else {
    print("This isn't A Trangle!!")
}


