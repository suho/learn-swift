//
//  StringExtension.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/4/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

extension String {
    func checkValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(self)
        return result
    }
}