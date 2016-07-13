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
    
    var isViewSignUp = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrowImage.frame.origin.x = signUpButton.center.x
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func moveViewSignUp(sender: AnyObject) {
        if !isViewSignUp {
            isViewSignUp = true
            enterButton.setBackgroundImage(UIImage(named: "ActiveEnter"), forState: .Normal)
            
            UIImageView.animateWithDuration(0, animations: {
                self.arrowImage.frame.origin.x = self.signUpButton.center.x
                }, completion: { (complete) in
                    
            })
        }
    }
    @IBAction func moveViewLogin(sender: AnyObject) {
        if isViewSignUp {
            isViewSignUp = false
            enterButton.setBackgroundImage(UIImage(named: "InactiveEnter"), forState: .Normal)
            
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(test), userInfo: nil, repeats: false)
        }
    }
    
    func test() {
        var temp = self.arrowImage.center
        temp.x = self.loginButton.center.x
        
        UIImageView.animateWithDuration(0.3, animations: {
            self.arrowImage.center = temp
            }, completion: { (complete) in
                //self.arrowImage.frame.origin.x = self.loginButton.center.x
        })
    }
    
    @IBAction func enterAction(sender: AnyObject) {
    }
    @IBAction func facebookAction(sender: AnyObject) {
    }
    @IBAction func twitterAction(sender: AnyObject) {
    }
}
