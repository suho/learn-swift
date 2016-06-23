//
//  HomeViewController.swift
//  SpecialExercise3-Day23-06
//
//  Created by Mylo Ho on 6/23/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textFieldDay: UITextField!
    @IBOutlet weak var textFieldMonth: UITextField!
    @IBOutlet weak var textFieldYear: UITextField!
    @IBOutlet weak var labelDay: UILabel!
    
    @IBAction func showDayOfDate(sender: AnyObject) {
        self.showDay()
    }
    
    func showDay() {
        self.labelDay.text = ""
        
        if self.textFieldDay.text == "" || self.textFieldMonth.text == "" || self.textFieldYear.text == "" {
            self.showMessage()
            return
        }
        
        
        let dayNumber: Int = Int(self.textFieldDay.text!)!
        let monthNumber: Int = Int(self.textFieldMonth.text!)!
        let yearNumber: Int = Int(self.textFieldYear.text!)!
        
        let date: String = "\(dayNumber)-\(monthNumber)-\(yearNumber)"
        switch self.getDayOfWeek(date) {
        case 1:
            self.labelDay.text = "Sunday"
            self.labelDay.textColor = UIColor.greenColor()
        case 2:
            self.labelDay.text = "Monday"
            self.labelDay.textColor = UIColor.greenColor()
        case 3:
            self.labelDay.text = "Tuesday"
            self.labelDay.textColor = UIColor.greenColor()
        case 4:
            self.labelDay.text = "Wednesday"
            self.labelDay.textColor = UIColor.greenColor()
        case 5:
            self.labelDay.text = "Thursday"
            self.labelDay.textColor = UIColor.greenColor()
        case 6:
            self.labelDay.text = "Friday"
            self.labelDay.textColor = UIColor.greenColor()
        case 7:
            self.labelDay.text = "Saturday"
            self.labelDay.textColor = UIColor.greenColor()
        default:
            self.labelDay.text = "Wrong Day!!"
            self.labelDay.textColor = UIColor.redColor()
        }

    }
    
    func getDayOfWeek(date: String) -> Int {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        if let todayDate = formatter.dateFromString(date) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return 8
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.textFieldDay.resignFirstResponder()
        self.textFieldMonth.resignFirstResponder()
        self.textFieldYear.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldDay.delegate = self
        self.textFieldMonth.delegate = self
        self.textFieldYear.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMessage() {
        let alert = UIAlertController(title: "Error", message: "Wrong Value!!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if self.textFieldDay == textField {
            let textFieldDay: NSString = textField.text ?? ""
            let textFieldDayNew = textFieldDay.stringByReplacingCharactersInRange(range, withString: string)
            
            if textFieldDayNew == "" {
                return true
            }
            
            if let number: Int = Int(textFieldDayNew) {
                if number < 0 || number > 31 {
                    self.showMessage()
                }
            } else {
                self.showMessage()
            }
        } else if self.textFieldMonth == textField {
            let textFieldMonth: NSString = textField.text ?? ""
            let textFieldMonthNew = textFieldMonth.stringByReplacingCharactersInRange(range, withString: string)
            
            if textFieldMonthNew == "" {
                return true
            }
            
            if let number: Int = Int(textFieldMonthNew) {
                if number < 0 || number > 12 {
                    self.showMessage()
                }
            } else {
                self.showMessage()
            }
        } else if self.textFieldYear == textField {
            let textFieldYear: NSString = textField.text ?? ""
            let textFieldYearNew = textFieldYear.stringByReplacingCharactersInRange(range, withString: string)
            
            if textFieldYearNew == "" {
                return true
            }
            
            if let number: Int = Int(textFieldYearNew) {
                if number < 0 {
                    self.showMessage()
                }
            } else {
                self.showMessage()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if self.textFieldDay == textField {
            self.textFieldMonth.becomeFirstResponder()
        } else if self.textFieldMonth == textField {
            self.textFieldYear.becomeFirstResponder()
        } else {
            self.showDay()
        }
        return true
    }
    
}


