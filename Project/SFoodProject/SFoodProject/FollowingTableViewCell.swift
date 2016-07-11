//
//  FollowingTableViewCell.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/11/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
