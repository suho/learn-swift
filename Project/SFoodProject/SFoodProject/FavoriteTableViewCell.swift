//
//  FavoriteTableViewCell.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/6/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var contentViewCustom: UIView!
    
    var location: Location = Location(images: ["a", "abc"], name: "Cafe ABC", address: "123 ABC, DEF, GHI", previewText: "", detailText: "", coordinates: (0, 0), isFavorite: true)
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func setFavoriteAction(sender: AnyObject) {
        self.starButton.setImage(UIImage(named: "no-star"), forState: .Normal)
        //self.location.isFavorite = false
        
        //Save Data
        //Reload TableView
    }
    
    func setView() -> Void {
        self.contentViewCustom.layer.masksToBounds = false
        self.contentViewCustom.layer.cornerRadius = self.contentViewCustom.frame.size.height/10
        self.contentViewCustom.clipsToBounds = true
    }
    
    func setData(location: Location) {
        self.location = location
        self.imageFirst.image = UIImage(named: location.images.first!)
        self.name.text = location.name
        self.address.text = location.address
        if self.location.isFavorite {
            self.starButton.setImage(UIImage(named: "orange-star"), forState: .Normal)
        } else {
            self.starButton.setImage(UIImage(named: "no-star"), forState: .Normal)
        }
    }
    
}
