//
//  CEOTableViewCell.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CEOTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatarImage.layer.borderWidth = 1
        self.avatarImage.layer.borderColor = UIColor.grayColor().CGColor
        self.avatarImage.layer.masksToBounds = true
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.height / 1.6
        self.avatarImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
