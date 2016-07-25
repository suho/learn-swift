//
//  AddClassViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class AddClassViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameFacultyTextField: UITextField!
    @IBOutlet weak var nameClassTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Class"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addAction(sender: AnyObject) {
    }
    @IBOutlet weak var addImageAction: UIButton!

}
