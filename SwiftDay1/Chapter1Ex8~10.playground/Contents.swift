//: Playground - noun: a place where people can play

import UIKit

//Bai 8: 
func bai8(giaTriX x: Double) -> Double{
    return x*x - sin(x)
}
let x = 1
print("Gia Tri Bieu Thuc Bai 8 = \(bai8(giaTriX: Double(x)))")


//Bai 9: Tinh 1 + ln(x^2)

func bai9(giaTriX x: Double) -> Double {
    return 1 + log(x*x)
}

print("Gia Tri 1 + ln(x^2) = \(bai9(giaTriX: Double(x)))")

//Bai 10: Tinh ch(x)
func bai10(giaTriX x: Double) -> Double {
    return (exp(x)+exp(-x))/2
}

print("Gia Tri ch(x) = \(bai10(giaTriX: Double(x)))")
