//
//  User.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/11/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation

class User {
    var idUser = 0
    var fullName = ""
    var username = ""
    var password = ""
    var email = ""
    var phone = ""
    var avatar = ""
    var gender = true
    var age = 20
    
    init(idUser: Int, fullName: String, username: String, password: String, email: String, phone: String, avatar: String, gender: Bool, age: Int) {
        self.idUser = idUser
        self.fullName = fullName
        self.username = username
        self.password = password
        self.email = email
        self.phone = phone
        self.avatar = avatar
        self.gender = gender
        self.age = age
    }
    
    init() {
    }
    
    func getDictionary() -> Dictionary<String, AnyObject> {
        return ["id": self.idUser, "name": self.fullName, "username": self.username, "password": self.password, "email": self.email, "phone": self.phone, "avatar": self.avatar, "gender": self.gender, "age": self.age]
    }
}