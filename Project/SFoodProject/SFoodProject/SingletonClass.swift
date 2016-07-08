//
//  SingletonClass.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

//Class constant

class Singleton  {
    static let sharedInstance = Singleton()
}

//Nested struct

class Singleton1 {
    class var sharedInstance: Singleton1 {
        struct Static {
            static let instance: Singleton1 = Singleton1()
        }
        return Static.instance
    }
}


//dispatch_once
//
//The traditional Objective-C approach ported to Swift. I'm fairly certain there's no advantage over the nested struct approach but I'm putting it here anyway as I find the differences in syntax interesting.

class Singleton2 {
    class var sharedInstance: Singleton2 {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Singleton2? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Singleton2()
        }
        return Static.instance!
    }
}