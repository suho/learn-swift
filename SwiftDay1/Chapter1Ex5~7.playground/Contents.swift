//: Playground - noun: a place where people can play

import UIKit

//Bài 5: Tính diện tích tam giác biết 3 cạnh
func isTriangle(canhA a: Double, canhB b: Double, canhC c: Double) -> Bool{
    return a + b > c && a + c > b && b + c > a ? true : false
}

func bai5(canhA a: Double, canhB b: Double, canhC c: Double) -> Double{
    if isTriangle(canhA: a, canhB: b, canhC: c) {
        let p = (a + b + c)/2 //Nua Chu Vi
        return sqrt(p*(p-a)*(p-b)*(p-c))
    } else {
        return -1
    }
}

let a: Double = 1
let b: Double = 2
let c: Double = 2
let dienTich = bai5(canhA: a, canhB: b, canhC: c)
if dienTich != -1 {
    print("Dien Tich Tam Giac = \(dienTich)")
} else {
    print("3 canh khong phai la tam giac")
}


//Bai 6: Tinh bieu thuc
func bai6(giaTriX x: Double) -> Double{
    return (9*x*x + 15)/(7*sqrt(x*x))
}
let x = 10
print("Gia Tri Bieu Thuc Bai 6 = \(bai6(giaTriX: Double(x)))")


//Bai 7: Tinh Cos(x^2)

func bai7(giaTriX x: Double) -> Double {
    return cos(x*x)
}

let giaTriX = 10
print("Gia Tri Cox(x^2) = \(bai7(giaTriX: Double(giaTriX)))")





