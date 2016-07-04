//
//  CEO.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class CEO {
    var avatar: String = "3"
    var name: String = "Nguyen Van A"
    var age: Int = 31
    var gender: Bool = true
    var avatarPath: String = ""
    
    init(avatar: String, name: String, age: Int, gender: Bool, avatarPath: String) {
        self.avatar = avatar
        self.name = name
        self.age = age
        self.gender = gender
        self.avatarPath = avatarPath
    }
}