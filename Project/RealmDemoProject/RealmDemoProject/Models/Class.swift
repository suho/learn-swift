//
//  Class.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import RealmSwift

class Class: Object {
    
    dynamic var idClass = ""
    dynamic var nameClass = ""
    dynamic var facultyName = ""
    
    let students = List<Student>()
    
}