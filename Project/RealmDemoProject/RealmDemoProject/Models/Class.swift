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
    dynamic var imageName = ""

    let students = List<Student>()

    override static func primaryKey() -> String? {
        return "idClass"
    }

    func delete() {
        do {
            let realm = try Realm()

            try realm.write({
                realm.delete(self)
            })

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
