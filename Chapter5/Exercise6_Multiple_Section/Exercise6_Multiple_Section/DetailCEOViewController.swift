//
//  DetailCEOViewController.swift
//  Exercise6_Multiple_Section
//
//  Created by Mylo Ho on 6/30/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class DetailCEOViewController: UIViewController {


    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    
    var indexRow: Int = 0
    var ceo = CEO(avatar: "3", name: "John", age: 31, gender: true, avatarPath: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.updateInformation))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = UIColor.grayColor().CGColor
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        
        if ceo.avatar == "" {
            self.avatar.image = UIImage(contentsOfFile: ceo.avatarPath)
        } else {
            self.avatar.image = UIImage(named: ceo.avatar)
        }
        self.name.text = ceo.name
        self.age.text = "\(ceo.age)"
        self.gender.selectedSegmentIndex = (ceo.gender) ? 0 : 1
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        if touch.view == self.view {
            self.name.resignFirstResponder()
            self.age.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInformation() {
        print("Pressed DONE")
    }
}
