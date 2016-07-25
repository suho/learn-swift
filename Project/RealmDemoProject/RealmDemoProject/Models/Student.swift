//
//  Student.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import RealmSwift

class Student: Object {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var age = 0
    dynamic var gender = true
    dynamic var imageName = ""
    
    let classObject = LinkingObjects(fromType: Class.self, property: "students")
    
}
