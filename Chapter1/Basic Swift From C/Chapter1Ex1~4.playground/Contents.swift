//: Playground - noun: a place where people can play

import UIKit


print("----Bài 1----")
let pi : Float = 3.14

func hinhCau(banKinh: Float) -> (Float, Float) {
    let theTichV : Float = (4*pi*banKinh*banKinh*banKinh)/3
    let dienTichS : Float = 4*pi*banKinh*banKinh
    return (theTichV, dienTichS)
}
let banKinh : Float = 2
let (theTich, dienTich) = hinhCau(banKinh)
print("Bán kính: \(banKinh)")
print("Thể Tích Hình Cầu = \(theTich), Diện Tích Hình Cầu = \(dienTich)")


//Bai tap 2
print("----Bài 2----")
func giaTriBieuThuc(bien: (Double, Double)) -> Double {
    let tu = log(fabs(bien.0*bien.0 - bien.1*bien.1))/log(5) + atan(bien.0 + bien.1)
    let mau = exp(bien.0) + cos(bien.0 + bien.1)
    return tu/mau
}

let giaTri : (Double, Double) = (1.5, 2)
let ketQua = giaTriBieuThuc(giaTri)
print("Giá trị của biểu thức = \(ketQua)")


print("----Bài 3----")
func bai3(x giaTriX: Double, y giaTriY: Double) -> Double {
    let tu = pow(5, giaTriX) + log(fabs(giaTriX - giaTriY))/log(5)
    let mau = 1 + atan(giaTriX + giaTriY)
    return tu/mau
}
let x: Double = 1.2
let y: Double = 5.1
let ketQuaBai3 = bai3(x: x, y: y)
print("Giá trị của biểu thức Bài 3 = \(ketQuaBai3)")



print("----Bài 4----")
let g: Double = 9.18 //Gia tốc trọng trường
func bai4(chieuDai l: Double) -> Double {
    return 2*Double(pi)*sqrt(l/g)
}
let l: Double = 10 //Giá trị chiều dài
print("Giá trị chu kỳ con lắc Bài 4 = \(bai4(chieuDai: l))")








