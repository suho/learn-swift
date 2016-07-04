//
//  Manager.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class Manager {
    var name: String = "John"
    var avatar: String = "1"
    var age: Int = 20
    var gender: Bool = true
    var avatarPath: String = ""
    var salary: Int = 1000
    
    init(avatar: String, name: String, age: Int, gender: Bool, avatarPath: String, salary: Int) {
        self.avatar = avatar
        self.name = name
        self.age = age
        self.gender = gender
        self.avatarPath = avatarPath
        self.salary = salary
    }
    
}