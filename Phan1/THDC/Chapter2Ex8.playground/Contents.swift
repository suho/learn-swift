//: Playground - noun: a place where people can play

import UIKit

let PI: Double = 3.14159

func anglesTrangle(a: Double, b: Double, c: Double) -> (Double, Double, Double) {
    
    //Check Trangle
    if (a>0) && (b>0) && (c>0) && (a+b>c) && (a+c>b) && (c+b>a) {
        var anglesA: Double = 0
        var anglesB: Double = 0
        var anglesC: Double = 0
        //Angles A: a^2 = b^2 + c^2 - 2*b*c*cosA
        let cosA = (b*b + c*c - a*a)/(2*c*b)
        if cosA == 0 {
            anglesA = PI/2
        } else if cosA == -1 {
            anglesA = PI
        } else {
            let tanA = sqrt(1 - cosA*cosA)/cosA
            if atan(tanA) < 0 {
                anglesA = (PI/2) - atan(tanA)
            } else {
                anglesA = atan(tanA)
            }
        }
        
        //Angles B: b^2 = a^2 + c^2 - 2*a*c*cosB
        let cosB = (a*a - b*b + c*c)/(2*a*c)
        if cosB == 0 {
            anglesB = PI/2
        } else if cosB == -1 {
            anglesB = PI
        } else {
            let tanB = sqrt(1 - cosB*cosB)/cosB
            if atan(tanB) < 0 {
                anglesB = (PI/2) - atan(tanB)
            } else {
                anglesB = atan(tanB)
            }
        }
        
        //Angles C: c^2 = b^2 + a^2 - 2*b*a*cosC
        let cosC = (a*a + b*b - c*c)/(2*a*b)
        if cosC == 0 {
            anglesC = PI/2
        } else if cosC == -1 {
            anglesC = PI
        } else {
            let tanC = sqrt(1 - cosC*cosC)/cosC
            if atan(tanC) < 0 {
                anglesC = (PI/2) - atan(tanC)
            } else {
                anglesC = atan(tanC)
            }
        }
        
        return radiansToDegress(anglesA, radiansB: anglesB, radiansC: anglesC)
    } else {
        return (0,0,0)
    }
}

func radiansToDegress(radiansA: Double, radiansB: Double, radiansC: Double) -> (Double, Double, Double) {
    let degressA = radiansA * 180 / PI
    let degressB = radiansB * 180 / PI
    let degressC = radiansC * 180 / PI
    return (degressA, degressB, degressC)
}


let trangle = anglesTrangle(3, b: 4, c: 5)

if trangle == (0, 0, 0) {
    print("Input Not Valid!!")
} else {
    print("3 Angles of Trangle:")
    print("Angles A = \(trangle.0)")
    print("Angles B = \(trangle.1)")
    print("Angles C = \(trangle.2)")
}




