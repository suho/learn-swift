//
//  ManagerTableViewCell.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class ManagerTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = UIColor.grayColor().CGColor
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = self.avatar.frame.size.height / 2.2
        self.avatar.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
