//
//  CardBookTableViewCell.swift
//  Excercise9_CardBook
//
//  Created by Mylo Ho on 7/1/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CardBookTableViewCell: UITableViewCell {

    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var imageKing: UIImageView!
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
