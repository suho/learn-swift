//
//  AddStudentViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameStudentTextField: UITextField!
    @IBOutlet weak var ageStudentTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Student"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addStudentAction(sender: AnyObject) {
    }
}
