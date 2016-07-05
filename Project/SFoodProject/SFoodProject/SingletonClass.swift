//
//  SingletonClass.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class SingletonClass: AnyObject { //Use Singleton
    
    class var sharedInstance: SingletonClass {
        struct Singleton {
            static let instance = SingletonClass()
        }
        return Singleton.instance
    }
    
}