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
        self.emailTextField.delegate = self
    }

    @IBAction func resetPasswordAction(sender: AnyObject) {
        let email = emailTextField.text!
        if email.checkValidEmail() {
            self.sendEmail(email)
        } else {
            self.showMessage("Email Not Valid")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func sendEmail(email: String) {
        //Do Something Here
        self.navigationController?.popViewControllerAnimated(true)
    }

}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.sendEmail(textField.text!)
        return true
    }
}

