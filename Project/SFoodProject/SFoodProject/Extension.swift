//
//  Extension.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/12/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func actionWhenShowKeyBoard() -> Void {
        var frame = self.frame
        if frame.origin.y < 0 {
            return
        } else {
            frame.origin.y = -140
            UIView.animateWithDuration(0.3, animations: {
                self.frame = frame
                }, completion: { (complete) in
                    
            })
        }
    }
    
    func actionWhenHideKeyBoard() -> Void {
        var frame = self.frame
        if frame.origin.y == 0 {
            return
        } else {
            frame.origin.y = 0
            UIView.animateWithDuration(0.5, animations: {
                self.frame = frame
                }, completion: { (complete) in
                    
            })
        }
    }
}

extension UIViewController {
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Message", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func convertDateToNameImage() -> String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        
        let dateString = format.stringFromDate(NSDate())
        
        return dateString
    }
}

extension String {
    
    func checkValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(self)
        return result
    }
    
    func checkValidNumber(minLenght: Int, maxLenght: Int) -> Bool {
        let numberRegEx = "[0-9]{\(minLenght),\(maxLenght)}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let result = numberTest.evaluateWithObject(self)
        return result
    }
    
}
