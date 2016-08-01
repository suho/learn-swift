//
//  CustomSearchTableViewCell.swift
//  YoutubeAPIProject
//
//  Created by Mylo Ho on 7/29/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CustomSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailVideo: UIImageView!
    @IBOutlet weak var titleVideoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
