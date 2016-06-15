//: Playground - noun: a place where people can play

import UIKit

//Bài 1: Giải hệ phương trình 2 biến
var x1: Double = 0
var x2: Double = 0
func giaiHePhuongTrinh(heSoA a: Double, heSoB b: Double, heSoC c: Double, heSoD d: Double, heSoE e: Double, heSoF f: Double) -> String{
    let dinhThuc = a*e - d*b
    let dx = c*e - f*b
    let dy = a*f - d*c
    if dinhThuc != 0 {
        x1 = dx/dinhThuc
        x2 = dy/dinhThuc
        return "Phuong Trinh Co Nghiem"
    } else if dx != 0 || dy != 0 {
        return "He Phuong Trinh Vo Nghiem"
    } else {
        return "He Phuong Trinh Vo Dinh"
    }
}

let result = giaiHePhuongTrinh(heSoA: 1, heSoB: 2, heSoC: 1, heSoD: 1, heSoE: 1, heSoF: 1)
if result == "Phuong Trinh Co Nghiem" {
    print(result + "\nNghiem 1 = \(x1)\nNghiem 2 = \(x2)")
} else {
    print(result)
}
print("-----------------------------------------")
//Bài 2: Giải phương trình bậc 2
var nghiem1: Double = 0
var nghiem2: Double = 0
func phuongTrinhBacHai(heSoA a: Double, heSoB b: Double, heSoC c: Double) -> String {
    if a==0 {
        if b==0 {
            if c==0 {
                return "Phuong Trinh Co Vo So Nghiem"
            } else {
                return "Phuong Trinh Vo Nghiem"
            }
        } else {
            nghiem1 = -c/b
            return "Phuong Trinh Co Mot Nghiem" + "\nNghiem = \(nghiem1)"
        }
    } else {
        let delta = b*b - 4*a*c
        if delta == 0 {
            nghiem1 = -b/(2*a)
            return "Phuong Trinh Co Mot Nghiem" + "\nNghiem = \(nghiem1)"
        } else if delta > 0 {
            nghiem1 = (-b + sqrt(delta))/(2*a)
            nghiem2 = (-b - sqrt(delta))/(2*a)
            return "Phuong Trinh Co 2 Nghiem" + "\nNghiem 1 = \(nghiem1)\nNghiem 2 = \(nghiem2)"
        } else {
            return "Phuong Trinh Vo Nghiem"
        }
    }
}
let str = phuongTrinhBacHai(heSoA: 1, heSoB: 2, heSoC: 1)
print(str)























