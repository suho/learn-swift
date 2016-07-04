//
//  Student.swift
//  Exercise3_TableView_Student
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class Student {
    var name: String?
    var avatar: String?
    var age: Int?
    var gender: String?
    
    init(name: String, avatar: String, age: Int, gender: String){
        self.name = name
        self.avatar = avatar
        self.age = age
        self.gender = gender
    }
}
