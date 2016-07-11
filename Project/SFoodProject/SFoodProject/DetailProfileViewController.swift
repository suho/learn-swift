//
//  DetailProfileViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/11/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class DetailProfileViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var changeInforButton: UIButton!
    
    var isChangeInformation = false
    
    var user = User()
    
    @IBAction func changeInformationAction(sender: AnyObject) {
        
        if isChangeInformation {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            self.fullName.enabled = true
            self.age.enabled = true
            self.email.enabled = true
            self.phone.enabled = true
            self.gender.enabled = true
            self.changeInforButton.setTitle("Save", forState: .Normal)
            self.isChangeInformation = true
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        let changeAccountButton: UIBarButtonItem = UIBarButtonItem(title: "Change Password", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.changePasword))
        
        self.navigationItem.rightBarButtonItem = changeAccountButton
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.avatar.border(self.avatar.frame.size.width / 2)
        
    }
    
    
    func changePasword() {
        let changePassword = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
        changePassword.user = self.user
        self.navigationController?.pushViewController(changePassword, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        self.fullName.text = self.user.fullName
        self.age.text = "\(self.user.age)"
        self.email.text = self.user.email
        self.phone.text = self.user.phone
        self.gender.selectedSegmentIndex = (self.user.gender) ? 0 : 1
        self.username.text = self.user.username
        if let image = UIImage(named: self.user.avatar) {
            self.avatar.image = image
        } else {
            self.avatar.image = UIImage(contentsOfFile: self.user.avatar)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIView {
    func border(width: CGFloat) {
        self.layer.cornerRadius = width
        self.clipsToBounds = true
    }
}
