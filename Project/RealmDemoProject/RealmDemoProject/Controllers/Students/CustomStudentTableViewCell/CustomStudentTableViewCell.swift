//
//  CustomStudentTableViewCell.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class CustomStudentTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setAvatarUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Set Avatar UI
    func setAvatarUI() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.layer.masksToBounds = true
    }

    // MARK: Set Data For Cell
    func setData(student: Student) {
        self.nameLabel.text = "Name:   \(student.name)"
        self.idLabel.text = "ID:     \(student.id)"
        self.genderLabel.text = "Gender: " + (student.gender ? "Male" : "Female")
        if !student.imageName.isEmpty {
            self.avatarImageView.image = FileManager.sharedInstance.loadFile(student.imageName, typeDirectory: .CachesDirectory)
        }
    }

}
