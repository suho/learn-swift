//
//  CustomClassTableViewCell.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CustomClassTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var avatarClassImageView: UIImageView!
    
    @IBOutlet weak var nameFacultyLabel: UILabel!
    @IBOutlet weak var nameClassLabel: UILabel!
    @IBOutlet weak var numberOfStudentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
