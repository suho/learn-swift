//
//  LocationTableViewCell.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contentViewCustom: UIView!
    @IBOutlet weak var contentBasic: UIView!
    
    var location: Location = Location(images: ["a", "abc"], name: "Cafe ABC", address: "123 ABC, DEF, GHI", previewText: "", detailText: "", coordinates: (0, 0))

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setView() {
        self.contentViewCustom.layer.borderWidth = 1
        self.contentViewCustom.layer.borderColor = UIColor.orangeColor().CGColor
        self.contentViewCustom.layer.masksToBounds = false
        self.contentViewCustom.layer.cornerRadius = self.contentViewCustom.frame.size.height/10
        self.contentViewCustom.clipsToBounds = true
    }
    
    func setData(location: Location) {
        self.imageFirst.image = UIImage(named: location.images.first!)
        self.name.text = location.name
        self.address.text = location.address
    }
    
}
