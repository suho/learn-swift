//: Playground - noun: a place where people can play

import UIKit

//Bài 3: Giải bất phương trình bậc 2 > 0
var x1: Double = 0
var x2: Double = 0
func giaiBatPhuongTrinhBac2(heSoA a: Double, heSoB b: Double, heSoC c: Double) -> String {
    if a == 0 {
        if b == 0 {
            if c > 0 {
                return "Bat Phuong Trinh Co Vo So Nghiem"
            } else {
                return "Bat Phuong Trinh Vo Nghiem"
            }
        } else {
            x1 = -c/b
            if b > 0 {
                return "Bat Phuong trinh co nghiem x > \(x1)"
            } else {
                return "Bat Phuong trinh co nghiem x < \(x1)"
            }
        }
    } else {
        let delta = sqrt(b) - 4*a*c
        if a > 0 {
            if delta <= 0 {
                return "Bat Phuong trinh dung voi moi x"
            } else {
                x1 = (-b-sqrt(delta))/(2*a)
                x2 = (-b-sqrt(delta))/(2*a)
                return "Bat Phuong trinh co nghiem x < \(x1) hoac x > \(x2)"
            }
        } else {
            if delta <= 0 {
                return "Bat Phuong Trinh Vo Nghiem"
            } else {
                x1 = (-b-sqrt(delta))/(2*a)
                x2 = (-b-sqrt(delta))/(2*a)
                return "Bat Phuong trinh co nghiem \(x1) < x < \(x2)"
            }
        }
    }
}

let str = giaiBatPhuongTrinhBac2(heSoA: -11, heSoB: 2, heSoC: 1)
print(str)