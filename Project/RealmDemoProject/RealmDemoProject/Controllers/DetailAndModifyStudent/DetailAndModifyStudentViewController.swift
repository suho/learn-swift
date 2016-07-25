//
//  DetailAndModifyStudentViewController.swift
//  RealmDemoProject
//
//  Created by Mylo Ho on 7/25/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class DetailAndModifyStudentViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setModifyButton()
    }
    
    @IBAction func deleteStudentAction(sender: AnyObject) {
    }
    //MARK: Set Right Button Of Navigation Bar
    func setModifyButton() {
        let modifyButton: UIBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(self.activeModifyAction))
        modifyButton.image = UIImage(named: "Edit")
        self.navigationItem.rightBarButtonItem = modifyButton
    }
    
    //MARK: Active Modify Action
    func activeModifyAction() {
        
    }

}
