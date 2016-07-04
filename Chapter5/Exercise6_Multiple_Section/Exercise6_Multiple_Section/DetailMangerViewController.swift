//
//  DetailMangerViewController.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class DetailMangerViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var salary: UITextField!
    
    var indexRow: Int = 0
    var manager = Manager(avatar: "1", name: "Smith", age: 18, gender: false, avatarPath: "", salary: 1000)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.updateInformation))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = UIColor.grayColor().CGColor
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        
        if manager.avatar == "" {
            self.avatar.image = UIImage(contentsOfFile: manager.avatarPath)
        } else {
            self.avatar.image = UIImage(named: manager.avatar)
        }
        self.name.text = manager.name
        self.age.text = "\(manager.age)"
        self.gender.selectedSegmentIndex = (manager.gender) ? 0 : 1
        self.salary.text = "\(manager.salary)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        if touch.view == self.view {
            self.name.resignFirstResponder()
            self.age.resignFirstResponder()
            self.salary.resignFirstResponder()
        }
    }
    
    func updateInformation() {
        print("Pressed Done")
    }
    

}
