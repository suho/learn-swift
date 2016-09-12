//
//  LocationTableViewCell.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contentViewCustom: UIView!
    @IBOutlet weak var contentBasic: UIView!
    @IBOutlet weak var starButton: UIButton!

    var location: Location = Location(id: "", images: [UIImage(named: "cafe 61")!], name: "Cafe ABC", address: "123 ABC, DEF, GHI", previewText: "", detailText: "", coordinates: (0, 0), isFavorite: false)

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func setFavoriteAction(sender: AnyObject) {
        if self.location.isFavorite {
            self.starButton.setImage(UIImage(named: "no-star"), forState: .Normal)
            do {
                let realm = try Realm()
                let venueFavorite = realm.objects(VenueRealm).filter("idVenue = '\(self.location.id)'").first
                venueFavorite?.deleteVenueFavorite()
            } catch let error as NSError {
                print(error)
            }
            self.location.isFavorite = false

        } else {
            self.starButton.setImage(UIImage(named: "orange-star"), forState: .Normal)
            let venueRealm = VenueRealm()
            do {
                let realm = try Realm()
                try realm.write({
                    venueRealm.idVenue = self.location.id
                    venueRealm.nameVenue = self.location.name
                    venueRealm.addressVenue = self.location.address
                })
            } catch let error as NSError {
                print(error)
            }
            venueRealm.addVenueFavorite()

            self.location.isFavorite = true
        }
    }

    func setView() {
        self.contentViewCustom.layer.masksToBounds = false
        self.contentViewCustom.layer.cornerRadius = self.contentViewCustom.frame.size.height / 10
        self.contentViewCustom.clipsToBounds = true
    }

    func setData(location: Location, image: UIImage) {
        self.location = location

        self.imageFirst.image = image

        self.name.text = location.name
        self.address.text = location.address
        if location.isFavorite {
            self.starButton.setImage(UIImage(named: "orange-star"), forState: .Normal)
        } else {
            self.starButton.setImage(UIImage(named: "no-star"), forState: .Normal)
        }
    }

}
