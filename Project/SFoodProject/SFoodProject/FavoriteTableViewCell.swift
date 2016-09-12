//
//  FavoriteTableViewCell.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var contentViewCustom: UIView!

    var location: Location = Location(id: "", images: [UIImage(named: "cafe 61")!], name: "Cafe ABC", address: "123 ABC, DEF, GHI", previewText: "", detailText: "", coordinates: (0, 0), isFavorite: true)

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func setFavoriteAction(sender: AnyObject) {
        self.starButton.setImage(UIImage(named: "no-star"), forState: .Normal)
        do {
            let realm = try Realm()
            let venueFavorite = realm.objects(VenueRealm).filter("idVenue = '\(self.location.id)'").first
            venueFavorite?.deleteVenueFavorite()
        } catch let error as NSError {
            print(error)
        }
    }

    func setView() -> Void {
        self.contentViewCustom.layer.masksToBounds = false
        self.contentViewCustom.layer.cornerRadius = self.contentViewCustom.frame.size.height / 10
        self.contentViewCustom.clipsToBounds = true
    }

    func setData(location: VenueRealm) {
        // self.imageFirst.image = location.images.first!
        self.location.id = location.idVenue
        self.name.text = location.nameVenue
        self.address.text = location.addressVenue
        self.starButton.setImage(UIImage(named: "orange-star"), forState: .Normal)

    }

}
