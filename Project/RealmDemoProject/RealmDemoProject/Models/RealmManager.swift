//
//  File.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {

    static let sharedInstance = RealmManager()

    func addObject(object: Object) {

        do {

            let realm = try Realm()
            try realm.write({
                realm.add(object)
            })

        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }

    func deleteObject(object: Object) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.delete(object)
            })

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func updateObjectWithPrimaryKeys(object: Object) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(object, update: true)
            })

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}
