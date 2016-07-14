//
//  LoginAndSignUpViewController.swift
//  BasicAppProject
//
//  Created by Mylo Ho on 7/13/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LoginAndSignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var leadingSpaceArrow: NSLayoutConstraint!
    
    var isViewSignUp = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        if isViewSignUp {
            self.leadingSpaceArrow.constant = self.signUpButton.center.x
        } else {
            self.leadingSpaceArrow.constant = self.loginButton.center.x
        }
        
    }

    @IBAction func moveViewSignUp(sender: AnyObject) {
        if !isViewSignUp {
            self.isViewSignUp = true
            self.enterButton.setBackgroundImage(UIImage(named: "ActiveEnter"), forState: .Normal)
            self.facebookButton.setBackgroundImage(UIImage(named: "ActiveFacebook"), forState: .Normal)
            self.twitterButton.setBackgroundImage(UIImage(named: "ActiveTwitter"), forState: .Normal)
            self.leadingSpaceArrow.constant = self.signUpButton.center.x
        }
    }
    
    @IBAction func moveViewLogin(sender: AnyObject) {
        if self.isViewSignUp {
            self.isViewSignUp = false
            self.enterButton.setBackgroundImage(UIImage(named: "InactiveEnter"), forState: .Normal)
            self.facebookButton.setBackgroundImage(UIImage(named: "InactiveFacebook"), forState: .Normal)
            self.twitterButton.setBackgroundImage(UIImage(named: "InactiveTwitter"), forState: .Normal)
            self.leadingSpaceArrow.constant = self.loginButton.center.x
        }
    }
    
    @IBAction func enterAction(sender: AnyObject) {
        if isViewSignUp {
            print("Sign Up")
        } else {
            print("Login")
        }
        
    }
    @IBAction func facebookAction(sender: AnyObject) {
        if isViewSignUp {
            print("Sign Up With Facbook")
        } else {
            print("Login With Facbook")
        }
    }
    @IBAction func twitterAction(sender: AnyObject) {
        if isViewSignUp {
            print("Sign Up With Twitter")
        } else {
            print("Login With Twitter")
        }
    }
}
