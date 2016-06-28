//
//  Student.swift
//  Exercise5_MasterDetail_Update
//
//  Created by Mylo Ho on 6/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class Student {
    var name: String = "John Smith."
    var age: Int = 18
    var gender: Bool = true
    var avatar: String = "3"
    var avatarPath: String = ""
    
    init(name: String, age: Int, gender: Bool, avatar: String, avatarPath: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.avatar = avatar
        self.avatarPath = avatarPath
    }
}