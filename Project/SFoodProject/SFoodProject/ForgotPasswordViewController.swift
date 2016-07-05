//
//  ForgotPasswordViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/4/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forgot Password"
        self.navigationController?.navigationBarHidden = false
    }

    @IBAction func resetPasswordAction(sender: AnyObject) {
        let email = emailTextField.text!
        if email.checkValidEmail() {
            self.sendEmail(email)
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            self.showMessage("Email Not Valid", viewController: self)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMessage(message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: "Message", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func sendEmail(email: String) {
        //Do Something Here
    }

}
