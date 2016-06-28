//
//  ProfileTableViewCell.swift
//  Exercise4_CustomCell_Navi
//
//  Created by Mylo Ho on 6/27/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatarImage.layer.borderWidth = 1.0
        self.avatarImage.layer.masksToBounds = false
        self.avatarImage.layer.borderColor = UIColor.grayColor().CGColor
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.height/2
        self.avatarImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
