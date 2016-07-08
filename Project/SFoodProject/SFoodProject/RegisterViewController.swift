//
//  RegisterViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/5/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBAction func registerAction(sender: AnyObject) {
        print("Dang Ky")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        self.navigationController?.navigationBarHidden = false
        self.avatar.layer.cornerRadius = self.avatar.frame.height/2
        self.avatar.layer.borderWidth = 1
        self.avatar.layer.borderColor = UIColor.orangeColor().CGColor
        self.avatar.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tab(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    
    
}
