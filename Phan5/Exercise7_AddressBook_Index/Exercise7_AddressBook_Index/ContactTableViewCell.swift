//
//  ContactTableViewCell.swift
//  Exercise7_AddressBook_Index
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var nameOnAvatar: UILabel!
    
    var textName: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCircleAvatar() {
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = UIColor.brownColor().CGColor
        self.avatar.clipsToBounds = true
        self.avatar.layer.cornerRadius = self.avatar.frame.size.height / 2.0
        self.avatar.layer.masksToBounds = true
    }
    
    func configureWithContact(contact: Contact) {
        self.avatar.image = contact.image
        self.name.text = contact.name
        self.phoneNumber.text = contact.phone
        self.nameOnAvatar.text = self.textName
        self.setCircleAvatar()
    }
    
}
