//
//  LoginViewController.swift
//  SFoodProject
//
//  Created by Mylo Ho on 7/4/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameTextField.text!
        let password = self.passwordTextField.text!
        
        if self.checkAccount(username, password: password) {
            //print("Dang nhap thanh cong")
            AppDelegate.sharedInstance().changeRootViewWhenLoginSuccess()
        } else {
            if self.checkValid(username, password: password) {
                self.showMessage("Input Not Valid", viewController: self)
            } else {
                self.showMessage("User Not Available", viewController: self)
            }
        }
    }
    @IBAction func forgotPasswordAction(sender: AnyObject) {
        //print("Quen Mat Khau")
        let forgotPassword = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgotPassword, animated: true)
        
    }
    @IBAction func registerAction(sender: AnyObject) {
        print("Dang Ky")
        //Will Push Navi Here
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        if touch.view == self.view {
            self.usernameTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    func checkAccount(username: String, password: String) -> Bool {
        if username == "admin" && password == "admin" {
            return true
        } else {
            return false
        }
    }
    
    func checkValid(username: String, password: String) -> Bool {
        if username == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func showMessage(message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: "Message", message: "\(message)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.loginAction(self)
        }
        return true
    }
}
