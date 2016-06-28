//
//  DetailViewController.swift
//  Exercise4_CustomCell_Navi
//
//  Created by Mylo Ho on 6/28/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var student = Student(name: "", avatar: "", age: 0, gender: true)

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PROFILE"
        
        self.gender.enabled = false
        
        self.avatar.layer.borderWidth = 1.0
        self.avatar.layer.masksToBounds = false
        self.avatar.layer.borderColor = UIColor.brownColor().CGColor
        self.avatar.layer.cornerRadius = self.avatar.frame.size.height/2
        self.avatar.clipsToBounds = true
        
        self.avatar.image = UIImage(named: "\(student.avatar)")
        self.name.text = student.name
        self.age.text = "\(student.age)"
        self.gender.selectedSegmentIndex = (student.gender) ? 0 : 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
