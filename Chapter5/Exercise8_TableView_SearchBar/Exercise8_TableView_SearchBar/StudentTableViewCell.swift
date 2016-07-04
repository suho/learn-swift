//
//  StudentTableViewCell.swift
//  Exercise8_TableView_SearchBar
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatar.layer.borderWidth = 1.0
        self.avatar.layer.masksToBounds = false
        self.avatar.layer.borderColor = UIColor.grayColor().CGColor
        self.avatar.layer.cornerRadius = self.avatar.frame.size.height/2.2
        self.avatar.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
