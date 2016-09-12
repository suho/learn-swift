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
        self.setAvatarUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Set Avatar UI
    func setAvatarUI() {
        self.avatarClassImageView.layer.cornerRadius = self.avatarClassImageView.frame.size.height / 2
        self.avatarClassImageView.layer.masksToBounds = true
    }

    // MARK: Set Data For Cell
    func setData(classObject: Class) {
        self.nameFacultyLabel.text = "Faculty:   \(classObject.facultyName)"
        self.nameClassLabel.text = "Class:     \(classObject.nameClass)"
        self.numberOfStudentLabel.text = "Number of Students: \(classObject.students.count)"
        if !classObject.imageName.isEmpty {
            self.avatarClassImageView.image = FileManager.sharedInstance.loadFile(classObject.imageName, typeDirectory: .CachesDirectory)
        }
    }

}
