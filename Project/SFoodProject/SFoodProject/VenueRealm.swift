//
//  VenueRealm.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import RealmSwift

class VenueRealm: Object {
    dynamic var idVenue = ""
    dynamic var nameVenue = ""
    dynamic var addressVenue = ""
    dynamic var isFavorite = true

    override static func primaryKey() -> String? {
        return "idVenue"
    }

    func addVenueFavorite() {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(self)
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func deleteVenueFavorite() {
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
