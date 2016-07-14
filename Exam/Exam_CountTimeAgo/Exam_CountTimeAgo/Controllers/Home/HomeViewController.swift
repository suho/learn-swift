//
//  HomeViewController.swift
//  Exam_CountTimeAgo
//
//  Created by Mylo Ho on 7/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    
    var pastDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        datePicker.maximumDate = NSDate()
        datePicker.datePickerMode = .DateAndTime
        datePicker.addTarget(self, action: #selector(self.getDate), forControlEvents: .ValueChanged)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.getNewTime), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        /*
         * Use Func Of Apple
         *
         *
        if let result = getResult() {
            if result.count > 1 {
                self.timeLabel.text = "\(result[0]) \(result[1])"
            } else {
                self.timeLabel.text = "\(result[0])"
            }
            
        }
         */
        
        self.timeLabel.text = self.getResult()
    }
    
    func getNewTime() {
        self.datePicker.maximumDate = NSDate()
    }
    
    func getDate(sender: UIDatePicker) {
        self.pastDate = sender.date
    }
    
    func convertDateToString(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd/hh/mm/ss"
        return dateFormatter.stringFromDate(date)
    }
    
    func splitStringDate(string: String) -> [Int] {
        let numbersOfDate = string.componentsSeparatedByString("/")
        var numbers = [Int]()
        for number in numbersOfDate {
            if let numberInt = Int(number) {
                numbers.append(numberInt)
            }
        }
        return numbers
    }
    
    func getResult() -> String {
        
        let datePresent: String = convertDateToString(NSDate())
        let datePast: String = convertDateToString(self.pastDate)
        
        let numbersDatePresent: [Int] = splitStringDate(datePresent)
        let numbersDatePast: [Int] = splitStringDate(datePast)
        
        var resultNumber = [Int]()
        
        for i in 0..<6 {
            resultNumber.append(numbersDatePresent[i]-numbersDatePast[i])
        }
        
        let shortResultNumber = getShortResultNumber(resultNumber)
        
        let finallyResult = getFinallyResult(shortResultNumber)
        
        let stringResult = getStringFromFinallyDictionary(finallyResult)
        
        return stringResult
        
        
    }
    
    func getStringFromFinallyDictionary(finallyResult: [Dictionary<String, Int>]) -> String {
        var arrayWithTwoUnit = [Dictionary<String, Int>]()
        
        var stringResult = ""
        
        
        if finallyResult.count > 1 {
            arrayWithTwoUnit = [finallyResult[0], finallyResult[1]]
            let index = arrayWithTwoUnit[0].startIndex.advancedBy(0)
            let index1 = arrayWithTwoUnit[1].startIndex.advancedBy(0)
            
            let keyOfUnit1: String = arrayWithTwoUnit[0].keys[index]
            let valueOfUnit1 = arrayWithTwoUnit[0][keyOfUnit1]!
            
            let keyOfUnit2: String = arrayWithTwoUnit[1].keys[index1]
            let valueOfUnit2 = arrayWithTwoUnit[1][keyOfUnit2]!
            
            
            stringResult = "\(valueOfUnit1)\(keyOfUnit1) \(valueOfUnit2)\(keyOfUnit2)"
        } else {
            arrayWithTwoUnit = finallyResult
            
            let index = arrayWithTwoUnit[0].startIndex.advancedBy(0)
            
            let keyOfUnit1: String = arrayWithTwoUnit[0].keys[index]
            let valueOfUnit1 = arrayWithTwoUnit[0][keyOfUnit1]!
            
            stringResult = "\(valueOfUnit1)\(keyOfUnit1)"
        }
        /*
         * Show All
         *
        stringResult = ""
        for dictionary in finallyResult {
            let index = dictionary.startIndex.advancedBy(0)
            let keyOfUnit: String = dictionary.keys[index]
            let valueOfUnit = dictionary[keyOfUnit]!
            
            stringResult += "\(valueOfUnit)\(keyOfUnit) "
        }
        */
        return stringResult
    }
    
    
    func getFinallyResult(shortNumber: [Dictionary<String, Int>]) ->  [Dictionary<String, Int>] {
        
        var finallyResult = [Dictionary<String, Int>]()
        
        var getMonth = ["month": 0]
        var getDay = ["day": 0]
        
        
        
        for dictionary in shortNumber {
            
            if let year = dictionary["year"] {
                var unit = "year"
                if year > 1 {
                    unit = "years"
                }
                finallyResult.append([unit: year])
            }
            
            if let month = dictionary["month"] {
                let unit = "month"
                getMonth[unit] = month
            }
            
            if let day = dictionary["day"] {
                let unit = "day"
                getDay[unit] = day
            }
            
        }
        
        let processMonthDayAndWeek = self.processMonthWeekDay(getMonth, day: getDay)
        
        for dictionary in processMonthDayAndWeek {
            finallyResult.append(dictionary)
        }
        
        for dictionary in shortNumber {
            
            
            
            if var hour = dictionary["hour"] {
                var unit = "hour"
                if hour > 1 {
                    unit = "hours"
                }
                
                if hour < 0 {
                    hour += 24
                }
                
                finallyResult.append([unit: hour])
            }
            
            if var minute = dictionary["minute"] {
                var unit = "minute"
                if minute > 1 {
                    unit = "minutes"
                }
                
                if minute < 0 {
                    minute += 60
                }
                
                finallyResult.append([unit: minute])
            }
            
            if var second = dictionary["second"] {
                var unit = "second"
                if second > 1 {
                    unit = "seconds"
                }
                
                if second < 0 {
                    second += 60
                }
                
                finallyResult.append([unit: second])
            }
        }
        
        return finallyResult
    }
    
    func processMonthWeekDay(month: Dictionary<String, Int>, day: Dictionary<String, Int>) -> [Dictionary<String, Int>] {
        
        var result = [Dictionary<String, Int>]()
        
        if month["month"]! == 0 {
            if day["day"]! != 0 {
                var numberDay = day["day"]!
                if numberDay < 0 {
                    numberDay += getMaxDayOfMoth(self.pastDate.monthYear.0, year: self.pastDate.monthYear.1)
                }
                
                let numberWeek = numberDay / 7
                
                if numberWeek != 0 {
                    var unit = "week"
                    if numberWeek > 1 {
                        unit = "weeks"
                    }
                    result.append([unit: numberWeek])
                }
                
                numberDay = numberDay % 7
                
                if numberDay != 0 {
                    var unit = "day"
                    if numberDay > 1 {
                        unit = "days"
                    }
                    result.append([unit: numberDay])
                }
            }
        } else {
            var numberMonth = month["month"]!
            if numberMonth < 0 {
                numberMonth += 12
            }
            
            var numberDay = day["day"]!
            
            if numberDay < 0 {
                numberMonth -= 1
            }
            
            if numberMonth != 0 {
                var unit = "month"
                if numberMonth > 1 {
                    unit = "months"
                }
                
                result.append([unit: numberMonth])
            }
            
            if numberDay != 0 {
                if numberDay < 0 {
                    numberDay += getMaxDayOfMoth(self.pastDate.monthYear.0, year: self.pastDate.monthYear.1)
                }
                
                let numberWeek = numberDay / 7
                
                if numberWeek != 0 {
                    var unit = "week"
                    if numberWeek > 1 {
                        unit = "weeks"
                    }
                    result.append([unit: numberWeek])
                }
                
                numberDay = numberDay % 7
                
                if numberDay != 0 {
                    var unit = "day"
                    if numberDay > 1 {
                        unit = "days"
                    }
                    result.append([unit: numberDay])
                }
            }
            
            
        }
        
        return result
    }
    
    func getMaxDayOfMoth(month: Int, year: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            if checkLeapYear(year) {
                return 29
            } else {
                return 28
            }
        default:
            return 30
        }
    }
    
    func checkLeapYear(year: Int) -> Bool {
        if (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) {
            return true
        }
        return false
    }
    
    func getShortResultNumber(numbers: [Int]) -> [Dictionary<String, Int>] {
        var shortResultNumber = [Dictionary<String, Int>]()
        
        for (index, number) in numbers.enumerate() {
            if number != 0 {
                switch index {
                case 0:
                    let unit = "year"
                    shortResultNumber.append([unit: number])
                case 1:
                    let unit = "month"
                    shortResultNumber.append([unit: number])
                case 2:
                    let unit = "day"
                    shortResultNumber.append([unit: number])
                case 3:
                    let unit = "hour"
                    shortResultNumber.append([unit: number])
                case 4:
                    let unit = "minute"
                    shortResultNumber.append([unit: number])
                default:
                    let unit = "second"
                    shortResultNumber.append([unit: number])
                }
            }
        }
        
        return shortResultNumber
    }
    
    func useFunction() -> [String]? {

         let dateComponentsFormatter = NSDateComponentsFormatter()
         dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Full
         
         let interval = NSDate().timeIntervalSinceDate(self.pastDate)
         
         guard let diffirentDate = dateComponentsFormatter.stringFromTimeInterval(interval) else {
         return nil
         }
         
         let arrayDiffirentDate = diffirentDate.componentsSeparatedByString(", ")
         
         if arrayDiffirentDate.count > 1 {
         return [arrayDiffirentDate[0], arrayDiffirentDate[1]]
         } else {
         return arrayDiffirentDate
         }
        
    }

}


extension NSDate {
    
    var monthYear: (Int, Int) {
        let components = NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: self)
        return (components.month, components.year)
    }
}
