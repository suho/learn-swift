//: Playground - noun: a place where people can play

import UIKit

let NORMS_NORMAL = 60
let NORMS_OFFICALS = 90
let NORMS_BUSINESS = 200
let NORMS_PRODUCE = 450

let MONEY_NORMS = 1000
let MONEY_NOT_NORMS = 2000

func moneyTotal(oldNumber: Int, newNumber: Int, type: String) -> Int {
    let number = newNumber - oldNumber
    switch type {
    case "normal":
        if number > NORMS_NORMAL {
           return (NORMS_NORMAL*MONEY_NORMS) + (number-NORMS_NORMAL)*MONEY_NOT_NORMS
        } else {
            return number*MONEY_NORMS
        }
    case "officals":
        if number > NORMS_OFFICALS {
            return (NORMS_OFFICALS*MONEY_NORMS) + (number-NORMS_OFFICALS)*MONEY_NOT_NORMS
        } else {
            return number*MONEY_NORMS
        }
    case "business":
        if number > NORMS_BUSINESS {
            return (NORMS_BUSINESS*MONEY_NORMS) + (number-NORMS_BUSINESS)*MONEY_NOT_NORMS
        } else {
            return number*MONEY_NORMS
        }
    case "procude":
        if number > NORMS_PRODUCE {
            return (NORMS_PRODUCE*MONEY_NORMS) + (number-NORMS_PRODUCE)*MONEY_NOT_NORMS
        } else {
            return number*MONEY_NORMS
        }
    default:
        return -1
    }
}


let total = moneyTotal(100, newNumber: 200, type: "normal")